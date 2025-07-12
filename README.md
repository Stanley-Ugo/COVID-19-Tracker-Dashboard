# 🦠 COVID-19 Tracker Dashboard (Flutter)

A cleanly-architected Flutter app that tracks real-time COVID-19 statistics using a public API. It visualizes:

- 📈 **Line Chart:** Daily new cases over the last 7 days
- 🍩 **Doughnut Chart:** Distribution of Active, Recovered, and Deaths

---

## ✨ Features

- ✅ Public API integration using `http`
- ✅ Line chart for 7-day trend of new cases
- ✅ Pie/doughnut chart for case breakdown
- ✅ Clean architecture with MVVM
- ✅ Full error and loading state handling
- ✅ Pull-to-refresh or refresh button
- ✅ Modular, testable, and scalable codebase

---

## 📸 Screenshots

> <img width="405" height="899" alt="image" src="https://github.com/user-attachments/assets/b24be798-8ea8-42a0-af46-c8abadfd2abb" />  <img width="406" height="848" alt="image" src="https://github.com/user-attachments/assets/b74b1daa-41ab-44a2-b161-1002ca8674ab" />



---

## 🧰 Tech Stack

| Layer          | Technology Used                  |
|----------------|----------------------------------|
| Framework      | [Flutter](https://flutter.dev)   |
| Charts         | [`fl_chart`](https://pub.dev/packages/fl_chart) |
| API Client     | `http`                           |
| Architecture   | MVVM (Model-View-ViewModel)      |
| State Mgmt     | `bloc`                           |
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
