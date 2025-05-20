echo "Начинаем установку зависимостей для Video-Transcription-Tool..."

# --- Шаг 2: Установка системных пакетов ---

# Установка Python и pip, если они не установлены
echo "Установка Python и pip..."
# Проверяем наличие python3
if ! command -v python3 &> /dev/null; then
    echo "Python3 не найден. Устанавливаем..."
    sudo apt-get install -y python3
else
    echo "Python3 уже установлен."
fi

# Проверяем наличие pip3 (часто идет вместе с python3, но лучше проверить)
if ! command -v pip3 &> /dev/null; then
    echo "pip3 не найден. Устанавливаем..."
    sudo apt-get install -y python3-pip
else
    echo "pip3 уже установлен."
fi

# Установка FFmpeg для обработки видео
echo "Установка FFmpeg..."
if ! command -v ffmpeg &> /dev/null; then
    echo "FFmpeg не установлен. Устанавливаем из стандартных репозиториев Ubuntu..."
    # Теперь, когда PPA удален и apt update прошел, установка из стандартных репо должна работать без проблем на Ubuntu 24.04.
    sudo apt-get install -y ffmpeg

    # Проверяем, успешно ли установился FFmpeg после попытки установки
    if command -v ffmpeg &> /dev/null; then
        echo "FFmpeg успешно установлен."
    else
        # Этот случай маловероятен на Ubuntu 24.04, если apt update отработал без серьезных ошибок
        echo "ВНИМАНИЕ: Не удалось установить FFmpeg из стандартных репозиториев."
        echo "Пожалуйста, попробуйте установить FFmpeg вручную командой: sudo apt-get install ffmpeg"
        # Если FFmpeg абсолютно необходим, можно добавить exit 1 здесь
        # exit 1
    fi
else
    echo "FFmpeg уже установлен."
fi

# Установка python3-venv для создания виртуального окружения
echo "Установка python3-venv..."
if ! command -v python3 -m venv &> /dev/null; then
    echo "Пакет python3-venv не найден. Устанавливаем..."
    sudo apt-get install -y python3-venv
else
    echo "Пакет python3-venv уже установлен."
fi


# --- Шаг 3: Настройка Python окружения ---

# Создание виртуального окружения Python
echo "Создание виртуального окружения Python в директории ./venv..."
# Создаем виртуальное окружение, если его нет
if [ ! -d "venv" ]; then
    python3 -m venv venv
    echo "Виртуальное окружение создано в ./venv."
else
    echo "Виртуальное окружение ./venv уже существует."
fi

# Активация виртуального окружения для выполнения следующих команд
echo "Активация виртуального окружения (в рамках текущего скрипта)..."
source venv/bin/activate
# Проверка, что активация прошла успешно (опционально)
if [ "$VIRTUAL_ENV" == "" ]; then
    echo "ВНИМАНИЕ: Не удалось активировать виртуальное окружение."
    echo "Установка Python-пакетов может пройти некорректно."
fi


# Обновление pip в виртуальном окружении
echo "Обновление pip в виртуальном окружении..."
pip install --upgrade pip

# Установка зависимостей из requirements.txt
echo "Установка Python-пакетов из requirements.txt..."
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
    if [ $? -ne 0 ]; then
        echo "ВНИМАНИЕ: Установка Python-пакетов завершилась с ошибками."
        echo "Пожалуйста, проверьте вывод выше на детали ошибки pip install."
    else
         echo "Установка Python-пакетов завершена."
    fi
else
    echo "ВНИМАНИЕ: Файл requirements.txt не найден в текущей директории."
    echo "Проект может не работать без установки необходимых Python-пакетов."
fi

# --- Шаг 5: Создание необходимых директорий ---
echo "Создание необходимых директорий для работы скрипта..."

# Создаем директории для видео, аудио и транскрипций, если они не существуют
mkdir -p video audio_segments transcribed_text
echo "Созданы директории: video, audio_segments, transcribed_text"

# --- Шаг 6: Завершение ---

echo "" # Пустая строка для разделения вывода
echo "--------------------------------------------------"
echo "Установка зависимостей завершена!"
echo "--------------------------------------------------"
echo "Для запуска проекта сначала активируйте виртуальное окружение:"
echo "  source venv/bin/activate"
echo ""
echo "ВАЖНО: Отредактируйте файл .env и замените 'ВАШ_КЛЮЧ_API_ЗДЕСЬ' на ваш настоящий API ключ Gemini."
echo "Получить ключ можно здесь: https://aistudio.google.com/apikey"
echo ""
echo "Для работы программы поместите видеофайлы в директорию 'video':"
echo "  cp /path/to/your/videos/*.mp4 video/"
echo "Затем запустите программу:"
echo "  python main.py"
echo "--------------------------------------------------"