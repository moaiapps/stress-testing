FROM debian:bullseye-slim

RUN apt update \
  && apt install -y python3 python3-pip wget gnupg \
  && wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
  && apt install -y ./google-chrome-stable_current_amd64.deb \
  && apt clean \
  && rm -rf /var/lib/apt/lists/ \
  && rm google-chrome-stable_current_amd64.deb

RUN pip3 install selenium chromedriver-binary~=$(/usr/bin/google-chrome --version | perl -pe 's/([^0-9]+)([0-9]+\.[0-9]+).+/$2/g')

WORKDIR /opt/app
COPY . .

ENV BOT_HEADLESS True
ENV PYTHONUNBUFFERED 1
CMD [ "python3", "-m", "stress_testing" ]
