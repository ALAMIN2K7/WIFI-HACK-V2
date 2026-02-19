clear
echo ""
echo "╔════════════════════════════════════════════════════╗"
echo "║      ╔╗╔╗╔╗╔══╗╔═══╗╔══╗⌔╔╗ ╔╗╔═══╗╔═══╗╔╗╔═╗      ║"
echo "║      ║║║║║║╚╣╠╝║╔══╝╚╣╠╝ ║║ ║║║╔═╗║║╔═╗║║║║╔╝      ║"
echo "║      ║║║║║║ ║║ ║╚══╗ ║║  ║╚═╝║║║ ║║║║ ╚╝║╚╝╝       ║"
echo "║      ║╚╝╚╝║ ║║ ║╔══╝ ║║  ║╔═╗║║╚═╝║║║ ╔╗║╔╗║       ║"
echo "║      ╚╗╔╗╔╝╔╣╠╗║║   ╔╣╠╗ ║║ ║║║╔═╗║║╚═╝║║║║╚╗      ║"
echo "║       ╚╝╚╝ ╚══╝╚╝   ╚══╝ ╚╝ ╚╝╚╝ ╚╝╚═══╝╚╝╚═╝      ║"
echo "║                    VERSION 2K7                     ║"
echo "║              TOOLS BY MOHAMMAD ALAMIN              ║"
echo "╚════════════════════════════════════════════════════╝"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Check if running in Termux
echo -e "${BLUE}[*]${NC} Checking Termux environment..."
if [ ! -d "/data/data/com.termux" ]; then
    echo -e "${RED}❌ ERROR: This script is designed for Termux only!${NC}"
    echo -e "${YELLOW}[!]${NC} Please install Termux from F-Droid and run this script inside Termux."
    exit 1
fi
echo -e "${GREEN}✅ Termux environment detected${NC}"

# Check Android version
echo -e "${BLUE}[*]${NC} Checking Android version..."
ANDROID_VERSION=$(getprop ro.build.version.release)
echo -e "${GREEN}✅ Android version: $ANDROID_VERSION${NC}"

# Check architecture
echo -e "${BLUE}[*]${NC} Checking device architecture..."
ARCH=$(uname -m)
echo -e "${GREEN}✅ Architecture: $ARCH${NC}"

# Check device manufacturer
echo -e "${BLUE}[*]${NC} Checking device manufacturer..."
MANUFACTURER=$(getprop ro.product.manufacturer)
echo -e "${GREEN}✅ Manufacturer: $MANUFACTURER${NC}"

# Check device model
echo -e "${BLUE}[*]${NC} Checking device model..."
MODEL=$(getprop ro.product.model)
echo -e "${GREEN}✅ Device Model: $MODEL${NC}"

# Check device codename (optional but cool 😎)
echo -e "${BLUE}[*]${NC} Checking device codename..."
CODENAME=$(getprop ro.product.device)
echo -e "${GREEN}✅ Device Codename: $CODENAME${NC}"

echo ""
echo -e "${PURPLE}╔════════════════════════════════════════════════════╗${NC}"
echo -e "${PURPLE}║               INSTALLATION STARTING                ║${NC}"
echo -e "${PURPLE}╚════════════════════════════════════════════════════╝${NC}"
echo ""

# Update Termux packages
echo -e "${CYAN}[1/11]${NC} 📱 Updating Termux packages..."
if pkg update -y && pkg upgrade -y; then
    echo -e "${GREEN}✅ Termux packages updated successfully${NC}"
else
    echo -e "${YELLOW}⚠️  Some packages may have failed to update (continuing...)${NC}"
fi

# Install core packages
echo -e "${CYAN}[2/11]${NC} 📦 Installing core packages..."
if pkg install -y python python-pip iw git root-repo; then
    echo -e "${GREEN}✅ Core packages installed${NC}"
else
    echo -e "${RED}❌ Failed to install core packages${NC}"
    exit 1
fi

# Make hack.py executable
echo -e "${CYAN}[3/11]${NC} 🔐 Setting executable permission for hack.py..."
if chmod +x hack.py; then
    echo -e "${GREEN}✅ hack.py is now executable${NC}"
else
    echo -e "${RED}❌ Failed to set permission for hack.py${NC}"
    exit 1
fi

# Copy hack.sh to Termux home directory
echo -e "${CYAN}[4/11]${NC} 📂 Copying hack.sh to home directory..."
if cp hack.sh /data/data/com.termux/files/home/; then
    echo -e "${GREEN}✅ hack.sh copied successfully${NC}"
else
    echo -e "${RED}❌ Failed to copy hack.sh${NC}"
    exit 1
fi

# Install requirements.txt
echo -e "${CYAN}[5/11]${NC} 📦 Installing requirements..."

if python -m pip install \
    "pyfiglet>=0.8.0" \
    "psutil>=5.8.0" \
    "requests>=2.25.0"; then
    echo -e "${GREEN}✅ requirements installed${NC}"
else
    echo -e "${RED}❌ Failed to install requirements${NC}"
    exit 1
fi


# Install privilege escalation tools
echo -e "${CYAN}[6/11]${NC} 🔐 Installing privilege escalation tools..."
if pkg install -y tsu; then
    echo -e "${GREEN}✅ Root tools installed${NC}"
else
    echo -e "${YELLOW}⚠️  Some root tools failed to install${NC}"
fi

# Install WiFi hacking tools
echo -e "${CYAN}[7/11]${NC} 📡 Installing WiFi security tools..."
pkg install -y pixiewps wpa-supplicant hashcat aircrack-ng || echo -e "${YELLOW}⚠️  Some WiFi tools may not be available on this architecture${NC}"
echo -e "${GREEN}✅ WiFi tools installation completed${NC}"

# Install Python dependencies
echo -e "${CYAN}[8/11]${NC} 🐍 Installing Python dependencies..."
if pip install --upgrade pip; then
    echo -e "${GREEN}✅ Pip upgraded${NC}"
fi

if pip install pyfiglet psutil requests; then
    echo -e "${GREEN}✅ Python dependencies installed${NC}"
else
    echo -e "${RED}❌ Failed to install Python dependencies${NC}"
    exit 1
fi

# Create necessary directories
echo -e "${CYAN}[9/11]${NC} 📁 Creating project directories..."
mkdir -p ~/.Hack/sessions
mkdir -p ~/.Hack/pixiewps
mkdir -p reports
echo -e "${GREEN}✅ Directories created${NC}"

# Set permissions
echo -e "${CYAN}[10/11]${NC} 🔧 Setting up permissions..."
chmod +x hack.py 2>/dev/null || echo "Main script not found (will be available after git clone)"
echo -e "${GREEN}✅ Permissions configured${NC}"

# Final setup
echo -e "${CYAN}[11/11]${NC} ✨ Finalizing installation..."
echo -e "${GREEN}✅ Installation completed successfully!${NC}"

echo ""
echo -e "${PURPLE}╔════════════════════════════════════════════════════╗${NC}"
echo -e "${PURPLE}║               INSTALLATION COMPLETE                ║${NC}"
echo -e "${PURPLE}╚════════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${GREEN}🎉 WiFi Hacker has been installed successfully!${NC}"
echo ""
echo -e "${BLUE}📋 NEXT STEPS:${NC}"
echo -e "${YELLOW}1.${NC} Grant root permissions: ${CYAN}tsu${NC}"
echo -e "${YELLOW}2.${NC} Run the tool: ${CYAN}python hack.py${NC}"
echo -e "${YELLOW}3.${NC} Select menu option for automatic hacking"
echo -e "${YELLOW}4.${NC} Enjoy! 🚀"
echo ""

echo -e "${BLUE}⚡ QUICK START:${NC}"
echo -e "${CYAN}tsu && python hack.py${NC}"
echo ""

echo -e "${BLUE}🔧 REQUIREMENTS:${NC}"
echo -e "${YELLOW}•${NC} Root access (use 'tsu' command)"
echo -e "${YELLOW}•${NC} WiFi enabled on device"
echo -e "${YELLOW}•${NC} Location services enabled"
echo -e "${YELLOW}•${NC} Target WiFi networks nearby"
echo ""

echo -e "${BLUE}📱 SUPPORT & UPDATES:${NC}"
echo -e "${YELLOW}•${NC} Telegram Account: ${CYAN}https://t.me/ALAMIN2K7${NC}"
echo -e "${YELLOW}•${NC} Get latest updates and support"
echo -e "${YELLOW}•${NC} Report bugs and request features"
echo ""

echo -e "${BLUE}⚖️  LEGAL REMINDER:${NC}"
echo -e "${RED}⚠️  Only use on networks you own or have permission to test${NC}"
echo -e "${RED}⚠️  Unauthorized WiFi hacking is illegal${NC}"
echo -e "${RED}⚠️  Educational and authorized testing only${NC}"
echo ""

echo -e "${GREEN}🛡️  Happy Ethical Hacking! 🛡️${NC}"
echo -e "${CYAN} Author MOHAMMAD ALAMIN${NC}"
echo ""

# Offer to open Telegram
read -p "🔗 Open Telegram Account now? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${BLUE}[*]${NC} Opening Telegram Account..."
    am start -a android.intent.action.VIEW -d "https://t.me/ALAMIN2K7" 2>/dev/null || \
    termux-open-url "https://t.me/ALAMIN2K7" 2>/dev/null || \
    echo -e "${YELLOW}[*]${NC} Please open: https://t.me/ALAMIN2K7"
fi

echo -e "${GREEN}Installation script completed! 🎉${NC}"
