# MoneyMate

MoneyMate is a personal finance management mobile application developed using Flutter. This application helps users manage their finances more efficiently by recording income and expenses, allocating funds into financial pockets, and splitting bills with friends or family.

The application is designed specifically for Indonesian users and uses Indonesian Rupiah (IDR) as the default currency for all financial transactions.

## Features

### Income and Expense Tracking

Users can:

* Add income transactions.
* Add expense transactions.
* Edit and delete transactions.
* View transaction history.
* Filter transactions by category and date.

### Financial Pockets

The Pockets feature allows users to allocate money for different financial goals, such as:

* Emergency Fund
* Vacation
* Education
* Monthly Budget
* New Gadget

Each pocket displays:

* Current balance
* Target amount
* Progress percentage
* Progress bar

### Split Bill

Users can split expenses with others by:

* Equal split
* Percentage split
* Custom amount split
* Split by items

Additional features:

* Payment status tracking
* Share results
* WhatsApp sharing
* Split bill history

### Dashboard

The dashboard provides:

* Total Balance
* Monthly Income
* Monthly Expenses
* Recent Transactions
* Pocket Overview
* Active Split Bills
* Income and Expense Charts

### Authentication

* Splash Screen
* Login
* Register
* Google Sign In
* Forgot Password

## Technology Stack

* Flutter
* Provider State Management
* Hive Local Database
* fl_chart
* intl
* Material Design 3

## Currency

MoneyMate uses Indonesian Rupiah (IDR) as the only currency format.

Examples:

* Rp 50.000
* Rp 150.000
* Rp 1.250.000
* Rp 10.500.000

## Project Structure

```text
lib/
├── models/
├── providers/
├── services/
├── screens/
├── widgets/
├── routes/
├── theme/
├── utils/
└── main.dart
```

## Getting Started

1. Clone this repository

```bash
git clone <repository_url>
```

2. Install dependencies

```bash
flutter pub get
```

3. Run the application

```bash
flutter run
```

## Developed By

MoneyMate Development Team

A modern and user-friendly finance application designed to help Indonesian users manage their money wisely.
