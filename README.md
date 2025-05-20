# Video Transcription Tool

Инструмент для автоматической транскрипции видеофайлов с использованием Google Gemini API.

## Описание

Этот инструмент автоматически извлекает аудио из видеофайлов, разделяет его на сегменты и создает транскрипцию с помощью Google Gemini API. Результаты сохраняются в форматах DOCX и TXT.

## Требования

- Python 3.7 или выше
- FFmpeg
- Google Gemini API ключ

## Установка

### Для Windows

1. **Установка Python**:
   - Скачайте и установите Python с [официального сайта](https://www.python.org/downloads/)
   - При установке отметьте опцию "Add Python to PATH"

2. **Установка FFmpeg**:
   - Скачайте FFmpeg с [официального сайта](https://ffmpeg.org/download.html) или используйте [gyan.dev сборку](https://www.gyan.dev/ffmpeg/builds/)
   - Распакуйте архив в удобное место (например, `C:\ffmpeg`)
   - Добавьте путь к папке `bin` в переменную среды PATH:
     - Нажмите Win + X и выберите "Система"
     - Выберите "Дополнительные параметры системы" -> "Переменные среды"
     - В разделе "Системные переменные" найдите PATH, выберите "Изменить"
     - Добавьте путь к папке bin (например, `C:\ffmpeg\bin`)
     - Нажмите OK

3. **Клонирование репозитория**:
   ```
   git clone <url-репозитория>
   cd split_video
   ```

4. **Создание виртуального окружения**:
   ```
   python -m venv venv
   venv\Scripts\activate
   ```

5. **Установка зависимостей**:
   ```
   pip install -r requirements.txt
   ```

6. **Настройка API ключа**:
   - Создайте файл `.env` в корневой папке проекта
   - Добавьте следующие строки:
     ```
     GEMINI_API_KEY=ваш_ключ_api
     GEMINI_MODEL=gemini-2.5-flash-preview-04-17
     ```
   - Замените `ваш_ключ_api` на ваш реальный API ключ Google Gemini

7. **Создание необходимых папок**:
   ```
   mkdir video
   mkdir transcribed_text
   ```

### Для Linux

1. **Автоматическая установка (рекомендуется)**:

   Выполните следующие команды для полной автоматической установки:

   ```bash
   # Установка git, если он не установлен
   sudo apt update
   sudo apt install -y git

   # Клонирование репозитория
   git clone https://github.com/Yaroslavlazarenko/Video-Transcription-Tool.git
   cd Video-Transcription-Tool

   # Установка прав на выполнение скрипта установки
   chmod +x install_dependencies.sh

   # Запуск скрипта установки
   ./install_dependencies.sh

   # Настройка .env файла
   nano .env
   ```

   В открывшемся редакторе nano введите следующее содержимое:
   ```
   # Настройки API для Gemini
   GEMINI_API_KEY=ваш_api_ключ_здесь
   GEMINI_MODEL=gemini-2.5-flash-preview-04-17
   ```

   Замените `ваш_api_ключ_здесь` на ваш реальный API ключ Google Gemini.
   
   Для сохранения файла в nano нажмите `Ctrl+O`, затем `Enter`, для выхода нажмите `Ctrl+X`.

   Скрипт автоматически установит Python, FFmpeg и все необходимые зависимости, создаст виртуальное окружение и настроит проект.

2. **Ручная установка**:

   - **Установка Python и FFmpeg**:
     ```
     sudo apt update
     sudo apt install python3 python3-pip python3-venv ffmpeg
     ```

   - **Клонирование репозитория**:
     ```
     git clone <url-репозитория>
     cd split_video
     ```

   - **Создание виртуального окружения**:
     ```
     python3 -m venv venv
     source venv/bin/activate
     ```

   - **Установка зависимостей**:
     ```
     pip install -r requirements.txt
     ```

   - **Настройка API ключа**:
     - Создайте файл `.env` в корневой папке проекта
     - Добавьте следующие строки:
       ```
       GEMINI_API_KEY=ваш_ключ_api
       GEMINI_MODEL=gemini-2.5-flash-preview-04-17
       ```
     - Замените `ваш_ключ_api` на ваш реальный API ключ Google Gemini

   - **Создание необходимых папок**:
     ```
     mkdir -p video transcribed_text
     ```

## Использование

1. Поместите видеофайлы в папку `video`

2. Запустите скрипт:
   ```
   # В Windows
   python main.py

   # В Linux
   python3 main.py
   ```

3. Дополнительные параметры:
   ```
   python main.py --help
   ```

   Доступные опции:
   - `--output`, `-o`: Директория для сохранения аудио сегментов
   - `--duration`, `-d`: Длительность сегмента в секундах (по умолчанию 600 секунд = 10 минут)
   - `--workers`, `-w`: Максимальное количество параллельных процессов для видео
   - `--transcription-workers`, `-tw`: Максимальное количество параллельных потоков для транскрипции
   - `--format`, `-f`: Формат аудио (mp3, aac, ogg, wav и т.д.)
   - `--bitrate`, `-b`: Битрейт аудио (напр. 128k, 192k, 320k)

4. Результаты транскрипции будут сохранены в папке `transcribed_text` в форматах DOCX и TXT

## Получение API ключа Google Gemini

1. Перейдите на сайт [Google AI Studio](https://aistudio.google.com/apikey)
2. Войдите в свой аккаунт Google
3. Нажмите на кнопку "Get API key" или "Create API key"
4. Скопируйте сгенерированный ключ
5. Вставьте ключ в файл `.env` в параметр `GEMINI_API_KEY`

## Структура проекта

```
Video-Transcription-Tool/
├── main.py               # Основной скрипт
├── requirements.txt      # Зависимости Python
├── install_dependencies.sh # Скрипт автоматической установки
├── .env                  # Файл с настройками API
├── video/                # Папка для исходных видеофайлов
└── transcribed_text/     # Папка для результатов транскрипции
```

## Примечания

- Для работы скрипта требуется действующий API ключ Google Gemini
- Для больших видеофайлов процесс может занять значительное время
- Качество транскрипции зависит от качества аудио и используемой модели Gemini
- Результаты сохраняются в двух форматах: DOCX (с форматированием) и TXT (простой текст)
