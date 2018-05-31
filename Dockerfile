FROM python:3 
ENV PYTHONUNBUFFERED 1
RUN mkdir /izone
WORKDIR /izone
ADD requirements.txt /izone/
RUN pip install -r requirements.txt
ADD . /izone/
