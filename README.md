# Blog Management App

A Flutter-based blog management application built with GetX for state management, connected to a live MockAPI backend.

---

## Tech Stack

| Layer | Technology |
|-------|------------|
| Framework | Flutter (Dart) |
| State Management | GetX v4.7.3 |
| HTTP Client | http v1.6.0 |
| Date Formatting | intl v0.20.2 |
| Backend | MockAPI.io |

---

## Features

- User Registration and Login with form validation
- View all blogs in a live feed with pull-to-refresh
- Create, edit, and delete blog posts
- Full blog detail view
- Responsive UI that adapts to different screen sizes
- Real-time UI updates using GetX reactive state

---

## Folder Structure

```
lib/
├── controllers/        # Business logic (AuthController, BlogController)
├── models/             # Data classes (BlogModel, UserModel)
├── screens/            # All app screens
├── services/           # API calls (ApiService)
├── utils/              # Constants, routes, theme, responsive helpers
├── widgets/            # Reusable UI components
└── main.dart           # Entry point
```

---

## Getting Started

Prerequisites: Flutter SDK, Dart SDK ^3.10.4

```bash
git clone <your-repo-url>
cd blog_management_app
flutter pub get
flutter run
```

---

## API

Connected to MockAPI.io. Base URL is set in `lib/utils/app_constants.dart`.

| Method | Endpoint | Action |
|--------|----------|--------|
| GET | /users | Fetch all users (used for login) |
| POST | /users | Register new user |
| GET | /blogs | Fetch all blogs |
| POST | /blogs | Create new blog |
| PUT | /blogs/:id | Update a blog |
| DELETE | /blogs/:id | Delete a blog |

---

## Screens

- **Login / Register** — Authentication screens with full validation
- **Home** — Blog feed with greeting and pull-to-refresh
- **Blogs** — Manage posts (edit, delete)
- **Add / Edit Blog** — Form screens for creating and updating posts
- **Blog Detail** — Full read view of a single post

---

## Notes

- Google Sign-In and Forgot Password are UI placeholders only
- Profile screen is not implemented in this version
- Passwords are stored as plain text on MockAPI (demo purposes only)
