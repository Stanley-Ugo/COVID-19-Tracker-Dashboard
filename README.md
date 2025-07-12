# COVID-19-Tracker-Dashboard
A Flutter-based COVID-19 tracker dashboard showing daily cases and case distribution with real-time data from a public API. Built using Clean Architecture and MVVM with asynchronous data handling, error states, and interactive charts.

# 🦠 COVID-19 Tracker Dashboard (Flutter)

A cleanly-architected Flutter app that tracks real-time COVID-19 statistics using a public API. It visualizes:

- 📈 **Line Chart:** Daily new cases over the last 7 days
- 🍩 **Doughnut Chart:** Distribution of Active, Recovered, and Deaths

---

## ✨ Features

- ✅ Public API integration using `http` or `dio`
- ✅ Line chart for 7-day trend of new cases
- ✅ Pie/doughnut chart for case breakdown
- ✅ Clean architecture with MVVM
- ✅ Full error and loading state handling
- ✅ Pull-to-refresh or refresh button
- ✅ Modular, testable, and scalable codebase

---

## 📸 Screenshots

> Add UI screenshots here of the dashboard screen, loading state, and error handling.

---

## 🧰 Tech Stack

| Layer          | Technology Used                  |
|----------------|----------------------------------|
| Framework      | [Flutter](https://flutter.dev)   |
| Charts         | [`fl_chart`](https://pub.dev/packages/fl_chart) or `syncfusion_flutter_charts` |
| API Client     | `dio` / `http`                   |
| Architecture   | MVVM (Model-View-ViewModel)      |
| State Mgmt     | `provider`, `riverpod`, or `bloc`|
| API Source     | [`disease.sh`](https://disease.sh/) or [`covid19api.com`](https://covid19api.com) |

---

## 🧱 Project Structure (MVVM + Clean Architecture)
lib/
├── core/
│ ├── error/
│ └── utils/
├── data/
│ ├── datasources/
│ ├── models/
│ └── repositories/
├── domain/
│ ├── entities/
│ └── usecases/
├── presentation/
│ ├── viewmodels/
│ ├── views/
│ └── widgets/
└── main.dart


---

## 🚀 Getting Started

### 1. Clone the repository
```bash
git clone https://github.com/Stanley-Ugo/COVID-19-Tracker-Dashboard.git
cd COVID-19-Tracker-Dashboard

flutter pub get

flutter run
