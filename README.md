# Lichi App

Lichi App — мобильное приложение, через которое можно смотреть каталог одежды с возможностью добавления товаров в корзину, выбора размеров и управления состоянием через BLoC.

---

## 📦 Структура проекта

Проект построен в формате **monorepo**, с несколькими локальными пакетами:

- `packages/lichi_api` — API клиент для работы с backend Lichi.
- `packages/lichi_repository` — слой репозитория для управления данными одежды.
- `packages/cart_storage_api` — API для хранения данных корзины локально.
- `packages/cart_storage_repository` — репозиторий для работы с корзиной.

---

## 🛠 Технологический стек

- **Flutter 3.32+**
- **Dart 3+**
- **State Management:** BLoC / flutter_bloc / hydrated_bloc
- **Code generation:** freezed, json_serializable, build_runner
- **Database:** Drift (SQLite)
- **Reactive programming:** RxDart / Rx
- **Fonts:** Google Fonts
- **UI:** Material + Cupertino

---

## 🚀 Установка и запуск

1. **Клонируйте репозиторий**
```bash
git clone <repository-url>
cd lichi-app
```
2. **Установка пакетов**
```bash
flutter pub get
```
3. **Кодогенерация**
```bash
dart run build_runner build --delete-conflicting-outputs

cd packages/lichi_api
dart run build_runner build --delete-conflicting-outputs

cd ../lichi_repository
dart run build_runner build --delete-conflicting-outputs
```

