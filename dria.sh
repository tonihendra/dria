#!/bin/bash

# Welcome message
echo "+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+"
echo "    Selamat Datang di Komunitas Kripto Ngapak"
echo "+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+"

# Install Docker
echo "Menginstal Docker..."
sudo apt-get update
sudo apt-get install -y docker.io

# Check if Docker was installed successfully
if ! command -v docker &> /dev/null; then
    echo "Gagal menginstal Docker. Silakan periksa kembali atau instal secara manual."
    exit 1
else
    echo "God Job Docker berhasil diinstal."
fi

# Install Docker Compose
echo "Proses Install Docker Compose..."
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Check if Docker Compose was installed successfully
if ! command -v docker-compose &> /dev/null; then
    echo "Gagal menginstal Docker Compose. instal secara manual."
    echo "Kunjungi https://docs.docker.com/compose/install/ untuk panduan instalasi."
    exit 1
else
    echo "Docker Compose berhasil diinstal."
fi

# Clone the repository
git clone https://github.com/firstbatchxyz/dkn-compute-node
cd dkn-compute-node

# Copy the environment file
cp .env.example .env

# Prompt for private key and OpenAI API key
read -p "Masukkan YOUR_PRIVATE_KEY: " PRIVATE_KEY
read -p "Masukkan YOUR_OPENAI_API_KEY: " OPENAI_API_KEY

# Add the keys to the .env file
echo "DKN_WALLET_SECRET_KEY=$PRIVATE_KEY" >> .env
echo "OPENAI_API_KEY=$OPENAI_API_KEY" >> .env

# Make the start script executable
chmod +x start.sh

# Run the start script with options
./start.sh --help

# Start the compute node with the specified mode
./start.sh -m=gpt-4o-mini
