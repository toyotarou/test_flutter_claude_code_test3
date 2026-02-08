package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"

	_ "github.com/go-sql-driver/mysql"
	"github.com/joho/godotenv"
)

var db *sql.DB

// HourseRaceList represents t_hourse_race_list table
type HourseRaceList struct {
	ID           int     `json:"id"`
	Year         *string `json:"year"`
	Month        *string `json:"month"`
	Day          *string `json:"day"`
	Grade        *string `json:"grade"`
	RaceName     *string `json:"race_name"`
	Place        *string `json:"place"`
	AgeRate      *string `json:"age_rate"`
	CourseKind   *string `json:"course_kind"`
	CourseLength *string `json:"course_length"`
	ResultURL    *string `json:"result_url"`
	Finish       *int    `json:"finish"`
}

// HourseNameStats represents horse name with stats
type HourseNameStats struct {
	HourseName string `json:"hourse_name"`
	RaceCount  int    `json:"race_count"`
	LastYear   string `json:"last_year"`
}

// HourseRaceResult represents t_hourse_race_result table
type HourseRaceResult struct {
	ID         int     `json:"id"`
	Year       *string `json:"year"`
	Month      *string `json:"month"`
	Day        *string `json:"day"`
	Grade      *string `json:"grade"`
	RaceName   *string `json:"race_name"`
	Result     *int    `json:"result"`
	HourseName *string `json:"hourse_name"`
	Age        *string `json:"age"`
	JockeyName *string `json:"jockey_name"`
	RaceTime   *string `json:"race_time"`
}

func init() {
	if err := godotenv.Load(); err != nil {
		log.Println("Warning: .env file not found, using environment variables")
	}
}

func main() {
	dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s?charset=utf8mb4&parseTime=True",
		os.Getenv("DB_USER"),
		os.Getenv("DB_PASS"),
		os.Getenv("DB_HOST"),
		os.Getenv("DB_PORT"),
		os.Getenv("DB_NAME"),
	)

	var err error
	db, err = sql.Open("mysql", dsn)
	if err != nil {
		log.Fatal("Failed to connect to database:", err)
	}
	defer db.Close()

	if err = db.Ping(); err != nil {
		log.Fatal("Failed to ping database:", err)
	}

	log.Println("Connected to database successfully")

	http.HandleFunc("/getAllRace", corsMiddleware(getAllRaceHandler))
	http.HandleFunc("/getRaceByYear", corsMiddleware(getRaceByYearHandler))
	http.HandleFunc("/getSelectedResult", corsMiddleware(getSelectedResultHandler))
	http.HandleFunc("/getResultByHourseName", corsMiddleware(getResultByHourseNameHandler))
	http.HandleFunc("/getAllHourseNames", corsMiddleware(getAllHourseNamesHandler))
	http.HandleFunc("/getAllHourseNamesWithStats", corsMiddleware(getAllHourseNamesWithStatsHandler))

	log.Println("Server starting on port 8080...")
	log.Fatal(http.ListenAndServe(":8080", nil))
}

func corsMiddleware(next http.HandlerFunc) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Access-Control-Allow-Origin", "*")
		w.Header().Set("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
		w.Header().Set("Access-Control-Allow-Headers", "Content-Type")

		if r.Method == "OPTIONS" {
			w.WriteHeader(http.StatusOK)
			return
		}

		next(w, r)
	}
}

func respondJSON(w http.ResponseWriter, data interface{}) {
	w.Header().Set("Content-Type", "application/json")
	if err := json.NewEncoder(w).Encode(data); err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
	}
}

func respondError(w http.ResponseWriter, message string, statusCode int) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(statusCode)
	json.NewEncoder(w).Encode(map[string]string{"error": message})
}

// getAllRaceHandler handles /getAllRace
// Returns all races ordered by year, month, day
func getAllRaceHandler(w http.ResponseWriter, r *http.Request) {
	query := "SELECT id, year, month, day, grade, race_name, place, age_rate, course_kind, course_length, result_url, finish FROM t_hourse_race_list ORDER BY year, month, day"

	rows, err := db.Query(query)
	if err != nil {
		respondError(w, "Database query error", http.StatusInternalServerError)
		log.Println("Query error:", err)
		return
	}
	defer rows.Close()

	var races []HourseRaceList
	for rows.Next() {
		var race HourseRaceList
		if err := rows.Scan(&race.ID, &race.Year, &race.Month, &race.Day, &race.Grade, &race.RaceName, &race.Place, &race.AgeRate, &race.CourseKind, &race.CourseLength, &race.ResultURL, &race.Finish); err != nil {
			respondError(w, "Scan error", http.StatusInternalServerError)
			log.Println("Scan error:", err)
			return
		}
		races = append(races, race)
	}

	respondJSON(w, races)
}

// getRaceByYearHandler handles /getRaceByYear?year=YYYY
// Returns races for a specific year
func getRaceByYearHandler(w http.ResponseWriter, r *http.Request) {
	year := r.URL.Query().Get("year")
	if year == "" {
		respondError(w, "year parameter is required", http.StatusBadRequest)
		return
	}

	query := "SELECT id, year, month, day, grade, race_name, place, age_rate, course_kind, course_length, result_url, finish FROM t_hourse_race_list WHERE year = ? ORDER BY year, month, day"

	rows, err := db.Query(query, year)
	if err != nil {
		respondError(w, "Database query error", http.StatusInternalServerError)
		log.Println("Query error:", err)
		return
	}
	defer rows.Close()

	var races []HourseRaceList
	for rows.Next() {
		var race HourseRaceList
		if err := rows.Scan(&race.ID, &race.Year, &race.Month, &race.Day, &race.Grade, &race.RaceName, &race.Place, &race.AgeRate, &race.CourseKind, &race.CourseLength, &race.ResultURL, &race.Finish); err != nil {
			respondError(w, "Scan error", http.StatusInternalServerError)
			log.Println("Scan error:", err)
			return
		}
		races = append(races, race)
	}

	respondJSON(w, races)
}

// getSelectedResultHandler handles /getSelectedResult?year=YYYY&month=MM&day=DD&race_name=NAME
// Returns race results for a specific race
func getSelectedResultHandler(w http.ResponseWriter, r *http.Request) {
	year := r.URL.Query().Get("year")
	month := r.URL.Query().Get("month")
	day := r.URL.Query().Get("day")
	raceName := r.URL.Query().Get("race_name")

	if year == "" || month == "" || day == "" || raceName == "" {
		respondError(w, "year, month, day, and race_name parameters are required", http.StatusBadRequest)
		return
	}

	query := "SELECT id, year, month, day, grade, race_name, result, hourse_name, age, jockey_name, race_time FROM t_hourse_race_result WHERE year = ? AND month = ? AND day = ? AND race_name = ? ORDER BY result"

	rows, err := db.Query(query, year, month, day, raceName)
	if err != nil {
		respondError(w, "Database query error", http.StatusInternalServerError)
		log.Println("Query error:", err)
		return
	}
	defer rows.Close()

	var results []HourseRaceResult
	for rows.Next() {
		var result HourseRaceResult
		if err := rows.Scan(&result.ID, &result.Year, &result.Month, &result.Day, &result.Grade, &result.RaceName, &result.Result, &result.HourseName, &result.Age, &result.JockeyName, &result.RaceTime); err != nil {
			respondError(w, "Scan error", http.StatusInternalServerError)
			log.Println("Scan error:", err)
			return
		}
		results = append(results, result)
	}

	respondJSON(w, results)
}

// getResultByHourseNameHandler handles /getResultByHourseName?hourse_name=NAME
// Returns all race results for a specific horse
func getResultByHourseNameHandler(w http.ResponseWriter, r *http.Request) {
	hourseName := r.URL.Query().Get("hourse_name")
	if hourseName == "" {
		respondError(w, "hourse_name parameter is required", http.StatusBadRequest)
		return
	}

	query := "SELECT id, year, month, day, grade, race_name, result, hourse_name, age, jockey_name, race_time FROM t_hourse_race_result WHERE hourse_name LIKE ? ORDER BY hourse_name, year, month, day"

	rows, err := db.Query(query, "%"+hourseName+"%")
	if err != nil {
		respondError(w, "Database query error", http.StatusInternalServerError)
		log.Println("Query error:", err)
		return
	}
	defer rows.Close()

	var results []HourseRaceResult
	for rows.Next() {
		var result HourseRaceResult
		if err := rows.Scan(&result.ID, &result.Year, &result.Month, &result.Day, &result.Grade, &result.RaceName, &result.Result, &result.HourseName, &result.Age, &result.JockeyName, &result.RaceTime); err != nil {
			respondError(w, "Scan error", http.StatusInternalServerError)
			log.Println("Scan error:", err)
			return
		}
		results = append(results, result)
	}

	respondJSON(w, results)
}

// getAllHourseNamesHandler handles /getAllHourseNames
// Returns all unique horse names sorted alphabetically
func getAllHourseNamesHandler(w http.ResponseWriter, r *http.Request) {
	query := "SELECT DISTINCT hourse_name FROM t_hourse_race_result WHERE hourse_name IS NOT NULL ORDER BY hourse_name"

	rows, err := db.Query(query)
	if err != nil {
		respondError(w, "Database query error", http.StatusInternalServerError)
		log.Println("Query error:", err)
		return
	}
	defer rows.Close()

	var names []string
	for rows.Next() {
		var name string
		if err := rows.Scan(&name); err != nil {
			respondError(w, "Scan error", http.StatusInternalServerError)
			log.Println("Scan error:", err)
			return
		}
		names = append(names, name)
	}

	respondJSON(w, names)
}

// getAllHourseNamesWithStatsHandler handles /getAllHourseNamesWithStats
// Returns all horse names with race count and last year of participation
func getAllHourseNamesWithStatsHandler(w http.ResponseWriter, r *http.Request) {
	query := "SELECT hourse_name, COUNT(*) as race_count, MAX(year) as last_year FROM t_hourse_race_result WHERE hourse_name IS NOT NULL GROUP BY hourse_name ORDER BY hourse_name"

	rows, err := db.Query(query)
	if err != nil {
		respondError(w, "Database query error", http.StatusInternalServerError)
		log.Println("Query error:", err)
		return
	}
	defer rows.Close()

	var stats []HourseNameStats
	for rows.Next() {
		var s HourseNameStats
		if err := rows.Scan(&s.HourseName, &s.RaceCount, &s.LastYear); err != nil {
			respondError(w, "Scan error", http.StatusInternalServerError)
			log.Println("Scan error:", err)
			return
		}
		stats = append(stats, s)
	}

	respondJSON(w, stats)
}
