# Project Bug Fixes and Enhancements

This README documents the bug fixes and enhancements applied to the project. Each fix includes the affected file, line number, and a brief explanation. These modifications improve functionality, performance, and code readability.

---

## 🛠 Fixes by Category

### 🗂 Model Layer

1. **GenreList Model**
   - **File:** `GenreList`
   - **Line 11** — Fixed typo: corrected `genr` to `genres` in the array declaration.

2. **Genre Model**
   - **File:** `Genre`
   - **Line 11** — Changed `id` property type from `Bool` to `Int` for accurate data representation.

---

### 🗂 Manager Layer

3. **GenreManager Class**
   - **File:** `GenreManager`
   - **Line 19** — Uncommented the completion return in the `fetchGenreList` function to ensure genres list is returned properly.
   - **Line 30** — Added `resume()` to the network call in the `fetchGenreList` function to start the request.

---

### 🗂 View Layer

4. **NowInTheaters Class**
   - **Line 19 & 21** — Added `[weak self]` to avoid retain cycles.
   - **Line 28** — Fixed the misspelled `MovieCollectionView`.
   - **Line 44-45** — Implemented `DispatchQueue.main.asyncAfter` to create a new cell, ensuring values are populated in time.
   - **Line 45** — Modified to choose and display a random element from the array for a dynamic experience.
   - **Line 58** — Added a cell size function to set the row height to 523 for the collection view.

5. **MovieCollectionView Class**
   - **Line 20** — Fixed spelling of `MovieCollectionViewCell`.
   - **Line 57** — Corrected the registration spelling from `MovieCollectionViewCll` to `MovieCollectionViewCell`.

6. **FeaturedCell Class**
   - **Line 23 & 29** — Added `[weak self]` to avoid retain cycles.
   - **Line 58** — Added string formatting for better display of movie ratings.

7. **SearchViewController Class**
   - **Line 41, 44, 63, 66** — Added `[weak self]` in multiple closures to prevent retain cycles.

---

## 📜 Summary of Changes

The changes made in this project enhance the overall code quality, improve memory management, and ensure the correct functioning of features. This README serves as a record of the modifications for future reference.

---

## 🚀 Getting Started

To run this project locally, follow these steps:

1. Clone the repository:
   ```bash
   git clone <repository-url>

