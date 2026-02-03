<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Will you be my Valentine? 💕</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, #ffc3a0 0%, #ffafbd 100%);
            overflow: hidden;
        }

        .container {
            text-align: center;
            background: rgba(255, 255, 255, 0.95);
            padding: 60px 40px;
            border-radius: 30px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
            max-width: 500px;
            width: 90%;
        }

        h1 {
            color: #d63447;
            font-size: 2.5em;
            margin-bottom: 40px;
            font-weight: bold;
        }

        .heart-emoji {
            font-size: 3em;
            margin-bottom: 20px;
            animation: heartbeat 1.5s infinite;
        }

        @keyframes heartbeat {
            0%, 100% { transform: scale(1); }
            10%, 30% { transform: scale(0.9); }
            20%, 40% { transform: scale(1.1); }
        }

        .buttons {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 20px;
            margin-top: 40px;
            min-height: 200px;
            position: relative;
            width: 100%;
        }

        button {
            padding: 20px 40px;
            font-size: 1.5em;
            border: none;
            border-radius: 15px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: bold;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            position: absolute;
        }

        #yesBtn {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            transform: scale(1);
            z-index: 10;
            left: 20%;
        }

        #yesBtn:hover {
            transform: scale(1.1);
            box-shadow: 0 8px 20px rgba(245, 87, 108, 0.4);
        }

        #noBtn {
            background: linear-gradient(135deg, #a8a8a8 0%, #7f7f7f 100%);
            color: white;
            transform: scale(1);
            right: 20%;
        }

        /* Success Screen */
        .success-screen {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 50%, #ffecd2 100%);
            z-index: 1000;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }

        .success-screen.active {
            display: flex;
        }

        .success-message {
            font-size: 3em;
            color: #d63447;
            font-weight: bold;
            margin-bottom: 30px;
            animation: fadeInScale 0.8s ease;
            text-align: center;
        }

        @keyframes fadeInScale {
            from {
                opacity: 0;
                transform: scale(0.5);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        /* Floating Hearts */
        .heart {
            position: fixed;
            font-size: 2em;
            color: #ff69b4;
            animation: float-up 4s ease-in infinite;
            opacity: 0;
            z-index: 999;
        }

        @keyframes float-up {
            0% {
                opacity: 0;
                transform: translateY(0) rotate(0deg);
            }
            10% {
                opacity: 1;
            }
            90% {
                opacity: 1;
            }
            100% {
                opacity: 0;
                transform: translateY(-100vh) rotate(360deg);
            }
        }

        .emoji-rain {
            position: fixed;
            font-size: 1.5em;
            animation: fall 3s linear infinite;
            z-index: 998;
        }

        @keyframes fall {
            to {
                transform: translateY(100vh) rotate(360deg);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="heart-emoji">❤️</div>
        <h1>Can I be yours? 💗</h1>
        
        <div class="buttons">
            <button id="yesBtn">Yes</button>
            <button id="noBtn">No</button>
        </div>
    </div>

    <div class="success-screen" id="successScreen">
        <div class="success-message">
            Yaayyy i knew it 💋
        </div>
    </div>

    <script>
        const yesBtn = document.getElementById('yesBtn');
        const noBtn = document.getElementById('noBtn');
        const successScreen = document.getElementById('successScreen');
        let noClickCount = 0;
        let yesScale = 1;
        let noScale = 1;

        // Yes butonuna tıklama
        yesBtn.addEventListener('click', () => {
            successScreen.classList.add('active');
            createHearts();
            createEmojiRain();
        });

        // No butonuna hover veya tıklama - kaçış ve küçülme
        function handleNoButton() {
            noClickCount++;
            
            // No butonunu küçült
            noScale = Math.max(0.1, noScale - 0.15);
            noBtn.style.transform = `scale(${noScale})`;
            
            // Yes butonunu büyüt
            yesScale += 0.2;
            yesBtn.style.transform = `scale(${yesScale})`;
            
            // No butonunu rastgele bir konuma taşı - daha geniş alan
            const container = document.querySelector('.buttons');
            const containerRect = container.getBoundingClientRect();
            
            // Daha geniş hareket alanı için container'ın boyutlarını kullan
            const buttonWidth = noBtn.offsetWidth * noScale;
            const buttonHeight = noBtn.offsetHeight * noScale;
            
            const maxX = containerRect.width - buttonWidth - 20;
            const maxY = containerRect.height - buttonHeight - 20;
            
            // Rastgele pozisyon - her yöne gidebilir
            const randomX = Math.random() * maxX;
            const randomY = Math.random() * maxY;
            
            noBtn.style.left = randomX + 'px';
            noBtn.style.top = randomY + 'px';
            noBtn.style.right = 'auto';
            
            // Çok küçülürse görünmez yap
            if (noScale <= 0.2) {
                noBtn.style.opacity = '0';
                noBtn.style.pointerEvents = 'none';
            }
        }

        // Fare ile yaklaşınca kaçsın
        noBtn.addEventListener('mouseenter', handleNoButton);
        
        // Mobil için touch eventi
        noBtn.addEventListener('touchstart', (e) => {
            e.preventDefault();
            handleNoButton();
        });

        // Tıklama için de aynı fonksiyon
        noBtn.addEventListener('click', (e) => {
            e.preventDefault();
            handleNoButton();
        });

        // Kalp yağmuru oluştur
        function createHearts() {
            for (let i = 0; i < 50; i++) {
                setTimeout(() => {
                    const heart = document.createElement('div');
                    heart.className = 'heart';
                    heart.innerHTML = '❤️';
                    heart.style.left = Math.random() * 100 + 'vw';
                    heart.style.animationDelay = Math.random() * 2 + 's';
                    heart.style.fontSize = (Math.random() * 2 + 1) + 'em';
                    document.body.appendChild(heart);
                    
                    setTimeout(() => heart.remove(), 4000);
                }, i * 100);
            }
        }

        // Emoji yağmuru
        function createEmojiRain() {
            const emojis = ['💕', '💖', '💗', '💓', '💝', '💘', '💞', '🌹', '😍', '🥰'];
            
            for (let i = 0; i < 40; i++) {
                setTimeout(() => {
                    const emoji = document.createElement('div');
                    emoji.className = 'emoji-rain';
                    emoji.innerHTML = emojis[Math.floor(Math.random() * emojis.length)];
                    emoji.style.left = Math.random() * 100 + 'vw';
                    emoji.style.top = -50 + 'px';
                    emoji.style.animationDelay = Math.random() * 2 + 's';
                    emoji.style.animationDuration = (Math.random() * 2 + 2) + 's';
                    document.body.appendChild(emoji);
                    
                    setTimeout(() => emoji.remove(), 5000);
                }, i * 150);
            }
        }
    </script>
</body>
</html>
