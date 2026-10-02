<style>

header {
    top: env(safe-area-inset-top, 0px);
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 24px;
    padding: 22px clamp(20px, 5vw, 56px);
    border-bottom: 1px solid var(--roxo50P);
}

.marca {
    font-family: 'Inter', sans-serif;
    font-weight: 800;
    font-size: 19px;
    letter-spacing: -0.02em;
    color: var(--branco);
    white-space: nowrap;
}
.marca span { color: var(--verde); }

.header-direita {
    display: flex;
    align-items: center;
    gap: 22px;
}

.insta {
    font-family: 'Roboto', sans-serif;
    font-size: 14px;
    color: var(--roxoTextoMaisClaro);
    text-decoration: none;
    white-space: nowrap;
}
.insta:hover { color: var(--branco); }

.btn-apoie {
    font-family: 'Roboto', sans-serif;
    font-weight: 500;
    font-size: 14px;
    color: var(--laranja);
    background: transparent;
    border: 1px solid var(--laranja);
    border-radius: 6px;
    padding: 9px 18px;
    cursor: pointer;
    transition: background 0.15s ease, color 0.15s ease;
    white-space: nowrap;
}
.btn-apoie:hover { background: var(--laranja); color: var(--preto); }

</style>

<header>
    <div class="marca">MANAGER<span>MODE</span>.COM</div>
    <div class="header-direita">
        <a class="insta" href="https://instagram.com/yhureei" target="_blank" rel="noopener">@yhureei</a>
        <button class="btn-apoie" type="button">Apoie</button>
    </div>
</header>