FROM python:3.4

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip3 install -r requirements.txt
#RUN django-admin startproject exampleapp
RUN git clone https://github.com/rodrigo-ramos/exampleapp.git
#RUN python3 -c "import django; print(django.get_version())"
WORKDIR /usr/src/app/exampleapp/mysite
EXPOSE 8000
RUN python manage.py migrate
CMD ["python3.4", "manage.py", "runserver", "0.0.0.0:8000"]
#CMD ["python3.4", "manage.py", "elasticapm", "test"]
#CMD ["ls", "-lrth"]
