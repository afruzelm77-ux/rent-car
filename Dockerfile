FROM node:22-slim
RUN apt-get update && apt-get install -y --no-install-recommends unzip ca-certificates postgresql-client \
 && rm -rf /var/lib/apt/lists/*
WORKDIR /app
# Butun loyiha app.zip ichida — GitHub'ga faqat 3 ta fayl yuklanadi (telefondan qulay)
COPY app.zip /tmp/app.zip
RUN unzip -q /tmp/app.zip -d /app && rm /tmp/app.zip && mkdir -p uploads backups
RUN npm ci --omit=dev
ENV NODE_ENV=production TZ=Asia/Tashkent
EXPOSE 3000
CMD ["node", "scripts/supervisor.js"]
