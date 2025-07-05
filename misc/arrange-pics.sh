#!/bin/bash

show_help() {
  cat <<EOF
Использование: arrange-pics.sh <префикс> -w <ширина> (-c | -r | -a)

Описание:
  Скрипт объединяет изображения с указанным префиксом в текущей директории в один общий файл.
  Поддерживаются форматы: jpg, jpeg, png, webp.

Аргументы:
  <префикс>      Префикс имени файлов для поиска.
  -w <ширина>    Ширина изображений после изменения размера (в пикселях).
  -c, --column   Склеить изображения вертикально.
  -r, --row      Склеить изображения горизонтально.
  -a, --auto     Автоматическая компоновка изображений.
                 Логика:
                   - 2 или 3 изображения: в одну строку.
                   - 4 изображения: в два ряда по 2.
                   - 5 изображений: в два ряда, 3 в первом и 2 во втором (с заглушкой).
                   - 6 изображений: в два ряда по 3.
                   - 7 изображений: в два ряда, 4 в первом и 3 во втором (с заглушкой).
                   - 8 изображений: в два ряда по 4.
                   - 9 изображений: в три ряда по 3.
                   - 10 изображений: 4, 4 и 2 в третьем (с заглушкой).
                   - 11 изображений: 4, 4 и 3.
                   - 12 изображений: в три ряда по 4.
  -h, --help     Показать это сообщение и выйти.

Примеры:
  Горизонтальное объединение:
    ./arrange-pics.sh example -w 500 -r

  Вертикальное объединение:
    ./arrange-pics.sh example -w 500 -c

  Автоматическая компоновка:
    ./arrange-pics.sh example -w 500 -a
EOF
}

# Проверка ключей -h и --help
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  show_help
  exit 0
fi

# Проверка параметров
if [[ -z "$1" || -z "$2" || "$2" != "-w" || -z "$3" ]]; then
  echo "Ошибка: недостаточно параметров. Используйте -h для справки."
  exit 1
fi

# Параметры
prefix=$1
width=$3
mode=""

# Проверка режима
case "$4" in
  -c|--column)
    mode="column"
    ;;
  -r|--row)
    mode="row"
    ;;
  -a|--auto)
    mode="auto"
    ;;
  *)
    echo "Ошибка: не указан режим. Используйте -h для справки."
    exit 1
    ;;
esac

# Текущая папка и имя выходного файла
dir=$(pwd)
output_file="${prefix}_combined.jpg"

echo "Ищем файлы в: $dir"
echo "Префикс: $prefix"
# Найти все файлы с заданным префиксом и поддерживаемыми расширениями
files=($(find "$dir" -maxdepth 1 -type f -regex ".*${prefix}.*\.\(jpg\|jpeg\|png\|webp\)" | sort))
echo "Найденные файлы:"
printf "%s\n" "${files[@]}"

# Количество файлов
file_count=${#files[@]}

# Проверить, есть ли файлы
if [[ $file_count -eq 0 ]]; then
  echo "Файлы с префиксом $prefix не найдены."
  exit 1
fi

# Создание списка файлов для обработки
echo "Найдено $file_count файлов. Обработка..."

# Генерация команды для объединения изображений
if [[ "$mode" == "column" ]]; then
  convert -append "${files[@]}" -resize "${width}x" "$output_file"
elif [[ "$mode" == "row" ]]; then
  convert +append "${files[@]}" -resize "x${width}" "$output_file"
elif [[ "$mode" == "auto" ]]; then
  rows=()
  case $file_count in
    2|3)
      convert +append "${files[@]}" -resize "x${width}" "$output_file"
      ;;
    4)
      rows=("2" "2")
      ;;
    5)
      rows=("3" "2")
      ;;
    6)
      rows=("3" "3")
      ;;
    7)
      rows=("4" "3")
      ;;
    8)
      rows=("4" "4")
      ;;
    9)
      rows=("3" "3" "3")
      ;;
    10)
      rows=("4" "4" "2")
      ;;
    11)
      rows=("4" "4" "3")
      ;;
    12)
      rows=("4" "4" "4")
      ;;
    15)
      rows=("4" "4" "4")
      ;;
    *)
      echo "Автоматическая компоновка не поддерживается для $file_count изображений."
      exit 1
      ;;
  esac

  if [[ ${#rows[@]} -gt 0 ]]; then
    temp_files=()
    idx=0
    for row_count in "${rows[@]}"; do
      row_files=("${files[@]:$idx:$row_count}")
      temp_row_output="${output_file}_row_${idx}.miff"
      convert +append "${row_files[@]}" -resize "x${width}" "$temp_row_output"
      temp_files+=("$temp_row_output")
      idx=$((idx + row_count))
    done
    convert -append "${temp_files[@]}" "$output_file"
    # Удаляем временные файлы
    rm -f "${temp_files[@]}"
  fi
fi

# Проверка успешности выполнения
if [[ $? -eq 0 ]]; then
  echo "Файлы успешно объединены в $output_file"
else
  echo "Ошибка при объединении файлов."
  exit 1
fi
