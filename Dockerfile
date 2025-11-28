FROM node:20-alpine

# 컨테이너 안에서 작업할 폴더
WORKDIR /app

# package.json 먼저 복사하고 의존성 설치
COPY package*.json ./
RUN npm install --only=production

# 나머지 소스 코드 복사
COPY . .

# 서버 포트 (main.js에서 쓰는 포트로 맞추기, 예: 3000)
ENV PORT=3000
EXPOSE 3000

# 컨테이너 시작할 때 실행할 명령어
CMD ["node", "main.js"]

