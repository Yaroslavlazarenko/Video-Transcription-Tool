#!/bin/bash

# Скрипт для установки всех зависимостей для проекта split_video
# Устанавливает Python, FFmpeg и необходимые Python-пакеты

echo "Начинаем установку зависимостей..."

# Обновление списка пакетов
echo "Обновление списка пакетов..."
sudo apt-get update

# Установка Python и pip, если они не установлены
echo "Установка Python и pip..."
if ! command -v python3 &> /dev/null; then
    sudo apt-get install -y python3
fi

if ! command -v pip3 &> /dev/null; then
    sudo apt-get install -y python3-pip
fi

# Установка FFmpeg для обработки видео
echo "Установка FFmpeg..."
if ! command -v ffmpeg &> /dev/null; then
    sudo apt-get install -y ffmpeg
fi

# Создание виртуального окружения Python (опционально)
echo "Создание виртуального окружения Python..."
if ! command -v python3 -m venv &> /dev/null; then
    sudo apt-get install -y python3-venv
fi

# Создаем виртуальное окружение, если его нет
if [ ! -d "venv" ]; then
    python3 -m venv venv
    echo "Виртуальное окружение создано."
else
    echo "Виртуальное окружение уже существует."
fi

# Активация виртуального окружения
echo "Активация виртуального окружения..."
source venv/bin/activate

# Обновление pip в виртуальном окружении
pip install --upgrade pip

# Установка зависимостей из requirements.txt
echo "Установка Python-пакетов из requirements.txt..."
pip install -r requirements.txt

# Проверка наличия файла .env
echo "Проверка файла .env..."
if [ ! -f ".env" ]; then
    echo "ВНИМАНИЕ: Файл .env не найден. Создаем шаблон файла .env."
    echo "# Настройки API для Gemini" > .env
    echo "GEMINI_API_KEY=ваш_ключ_api" >> .env
    echo "GEMINI_MODEL=gemini-2.5-flash-preview-04-17" >> .env
    echo "Создан шаблон файла .env. Пожалуйста, отредактируйте его и добавьте ваш API ключ."
else
    echo "Файл .env найден."
fi

echo "Установка завершена!"
echo "Для активации виртуального окружения используйте команду: source venv/bin/activate"
echo "ВАЖНО: Убедитесь, что в файле .env указан правильный API ключ для Gemini."
