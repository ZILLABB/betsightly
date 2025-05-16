#!/bin/bash
# Script to set up OpenMP environment variables

# Set up colors for output
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Setting up OpenMP environment variables...${NC}"

# Set environment variables for OpenMP
export OMP_NUM_THREADS=4
echo "export OMP_NUM_THREADS=4" >> ~/.bash_profile
echo "export OMP_NUM_THREADS=4" >> ~/.zshrc

echo -e "${GREEN}Environment variables set up successfully!${NC}"
echo -e "${YELLOW}OMP_NUM_THREADS=${OMP_NUM_THREADS}${NC}"

echo -e "${YELLOW}To apply these changes to your current shell session, run:${NC}"
echo -e "source ~/.bash_profile  # for bash"
echo -e "source ~/.zshrc         # for zsh"

echo -e "${GREEN}Setup completed!${NC}"
