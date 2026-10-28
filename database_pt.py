# import sys
import psycopg as pg
from prettytable import PrettyTable as PT

# Парсинг введённой пользователем строки/строк для передачи в виде SQL-запроса
def queryfix() -> str:
	lines = []
	while(1):
		line = input()
		if (line == '\\ex' or line == '\\dt'):
			lines.append(line)
			break
		if line.endswith(';'):
			lines.append(line.replace(';', ''))
			break
		lines.append(line)
	if (len(lines) < 2):
		query = lines[0]
	else:
		line = ' '.join(lines)
		query = line.replace('\t', '')
	return query

# Преобразуем в удобочитаемый вид
def readable_table(cur) -> list:
	columns = [desc[0] for desc in cur.description]
	table = PT(columns)
	table.add_rows(cur.fetchall())
	return table

# БД для подключения
# Здесь вводится назвыание своей БД, юзернейм и пароль
# Это небезопасно, сделано лишь для удобства в учебных целях
connStr = "dbname=applicant user=postgres password=12345"

# Выводим все таблицы
dt = """SELECT table_schema, table_name, table_type \
		FROM information_schema.tables \
        WHERE table_type = 'BASE TABLE' \
        AND table_schema NOT IN ('pg_catalog', 'information_schema')
        """

if __name__ == '__main__':
	with pg.connect(connStr) as conn:
		with conn.cursor() as cur:
			cur.execute(dt)
			print(readable_table(cur), "\n")
			while(1):
				print("Ввведите единичный(!) SQL-запрос для выполнения (; для окончания ввода запроса), \n\\dt для вывода всех таблиц или \\ex для выхода: ")
				query = queryfix()
				try:
					if (query == '\\ex'):
						break
					elif (query == '\\dt'):
						cur.execute(dt)
						print(readable_table(cur), "\n")
						continue
					cur.execute(query)
					if query.startswith("SELECT"):
						print("Результат запроса: \n")
						print(readable_table(cur), "\n")
					else:
						print("Запрос к БД выполнен успешно.\n")
					conn.commit()
				except Exception as e:
					print(f"Неверный запрос и/или иная ошибка: {e}")
					conn.rollback()
		conn.close()
