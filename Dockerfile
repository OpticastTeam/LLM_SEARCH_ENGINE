FROM python:3.11
WORKDIR /app
COPY . /app

RUN pip3 install -r requirements.txt
COPY . .

EXPOSE 8501

CMD ["streamlit", "run","streamlit_app.py"]