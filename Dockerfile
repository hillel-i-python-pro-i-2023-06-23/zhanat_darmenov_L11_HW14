FROM python:3.11

ENV PYTHONUNBUFFERED=1

ARG WORKDIR=/wd
ARG USER=user

WORKDIR ${WORKDIR}

RUN useradd --system ${USER} && \
    chown --recursive ${USER} ${WORKDIR}

RUN apt update && apt upgrade -y
RUN apt install -y curl

# Copy the requirements file separately to leverage Docker cache
COPY --chown=${USER} requirements.txt requirements.txt

RUN pip install --upgrade pip && \
    pip install --requirement requirements.txt

# Copy the application code into the container
COPY --chown=${USER} ./phonebook phonebook
COPY --chown=${USER} ./manage.py manage.py
COPY --chown=${USER} ./Makefile Makefile

USER ${USER}

VOLUME ${WORKDIR}/db

# Apply Django migrations:
RUN python manage.py makemigrations
RUN python manage.py migrate

# EXPOSE 8000

ENTRYPOINT ["python", "manage.py", "runserver"]
