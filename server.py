"""Сервер Telegram бота, запускаемый непосредственно"""
import logging
import os

import aiohttp
from aiogram import Bot, Dispatcher, executor, types

import exceptions
import expenses
from categories import Categories
from middlewares import AccessMiddleware


logging.basicConfig(level=logging.INFO)

API_TOKEN = os.getenv("TELEGRAM_API_TOKEN")
PROXY_URL = os.getenv("TELEGRAM_PROXY_URL")
PROXY_AUTH = aiohttp.BasicAuth(
    login=os.getenv("TELEGRAM_PROXY_LOGIN"),
    password=os.getenv("TELEGRAM_PROXY_PASSWORD")
)
ACCESS_ID = os.getenv("TELEGRAM_ACCESS_ID")

bot = Bot(token=API_TOKEN, proxy=PROXY_URL, proxy_auth=PROXY_AUTH)
dp = Dispatcher(bot)
dp.middleware.setup(AccessMiddleware(ACCESS_ID))


@dp.message_handler(commands=['start', 'help'])
async def send_welcome(message: types.Message):
    """Отправляет приветственное сообщение и помощь по боту"""
    await message.answer(
        "За цякучы дзень: /today\n"
        "За месяц: /month\n"
        "Апошнія выдаткі: /expenses\n"
        "Даступныя катэгорыі: /categories")


@dp.message_handler(lambda message: message.text.startswith('/del'))
async def del_expense(message: types.Message):
    """Удаляет одну запись о расходе по её идентификатору"""
    row_id = int(message.text[4:])
    expenses.delete_expense(row_id)
    answer_message = "Запіс выдалены"
    await message.answer(answer_message)


@dp.message_handler(commands=['categories'])
async def categories_list(message: types.Message):
    """Отправляет список категорий расходов"""
    categories = Categories().get_all_categories()
    answer_message = "Існуючыя катэгорыі:\n\n* " +\
            ("\n\n* ".join([c.name+' ('+", ".join(c.aliases)+')' for c in categories]))
    await message.answer(answer_message)


@dp.message_handler(commands=['today'])
async def today_statistics(message: types.Message):
    """Отправляет сегодняшнюю статистику трат"""
    answer_message = expenses.get_today_statistics()
    await message.answer(answer_message)


@dp.message_handler(commands=['month'])
async def month_statistics(message: types.Message):
    """Отправляет статистику трат текущего месяца"""
    answer_message = expenses.get_month_statistics()
    await message.answer(answer_message)


@dp.message_handler(commands=['expenses'])
async def list_expenses(message: types.Message):
    """Отправляет последние несколько записей о расходах"""
    last_expenses = expenses.last()
    if not last_expenses:
        await message.answer("Пакуль што ніякіх аперацый не існуе")
        return

    last_expenses_rows = [
        f"{expense.amount} руб. на {expense.category_name} — націсні "
        f"/del{expense.id} для выдалення"
        for expense in last_expenses]
    answer_message = "Апошнія захаваныя траты\n\n* " + "\n\n* "\
            .join(last_expenses_rows)
    await message.answer(answer_message)


@dp.message_handler()
async def add_expense(message: types.Message):
    """Добавляет новый расход"""
    try:
        expense = expenses.add_expense(message.text)
    except exceptions.NotCorrectMessage as e:
        await message.answer(str(e))
        return
    answer_message = (
        f"Дададзена {expense.amount} руб на {expense.category_name}.\n\n"
        f"{expenses.get_today_statistics()}")
    await message.answer(answer_message)


if __name__ == '__main__':
    executor.start_polling(dp, skip_updates=True)
