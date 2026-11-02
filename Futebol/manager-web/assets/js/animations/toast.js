/* ==========================================================
   TOAST - helper global reutilizável (precisa do toast.css)

   Uso:
     Toast.sucesso('Proposta enviada!');
     Toast.erro('Não foi possível conectar à API.');
     Toast.aviso('Orçamento baixo.');
     Toast.info('Nova rodada disponível.');
     Toast.mostrar('Texto', { tipo: 'sucesso', duracao: 5000 });

   Compatibilidade: mostrarAviso('texto') continua funcionando
   (equivale a Toast.sucesso).
   ========================================================== */
(function () {
    var ICONES = {
        sucesso: '✓',
        erro: '✕',
        aviso: '!',
        info: 'i'
    };

    var container = null;

    function obterContainer() {
        if (container && document.body.contains(container)) return container;
        container = document.createElement('div');
        container.className = 'toast-container';
        container.setAttribute('aria-live', 'polite');
        container.setAttribute('aria-atomic', 'false');
        document.body.appendChild(container);
        return container;
    }

    function fechar(toast) {
        if (!toast || toast.classList.contains('saindo')) return;
        toast.classList.add('saindo');
        toast.addEventListener('animationend', function () {
            toast.remove();
        }, { once: true });
        // garantia caso a animação não dispare
        setTimeout(function () { toast.remove(); }, 400);
    }

    function mostrar(mensagem, opcoes) {
        opcoes = opcoes || {};
        var tipo = ICONES[opcoes.tipo] ? opcoes.tipo : 'info';
        var duracao = opcoes.duracao > 0 ? opcoes.duracao : 3500;

        var toast = document.createElement('div');
        toast.className = 'toast ' + tipo;
        toast.setAttribute('role', tipo === 'erro' ? 'alert' : 'status');
        toast.style.setProperty('--toast-duracao', duracao + 'ms');

        var icone = document.createElement('span');
        icone.className = 'toast-icone';
        icone.textContent = ICONES[tipo];

        var texto = document.createElement('span');
        texto.className = 'toast-texto';
        texto.textContent = mensagem; // textContent: seguro contra HTML injetado

        var barra = document.createElement('span');
        barra.className = 'toast-barra';

        toast.appendChild(icone);
        toast.appendChild(texto);
        toast.appendChild(barra);

        var timer = setTimeout(function () { fechar(toast); }, duracao);

        // clicar fecha na hora
        toast.addEventListener('click', function () {
            clearTimeout(timer);
            fechar(toast);
        });

        // passar o mouse pausa o tempo; sair retoma
        toast.addEventListener('mouseenter', function () { clearTimeout(timer); });
        toast.addEventListener('mouseleave', function () {
            timer = setTimeout(function () { fechar(toast); }, 1500);
        });

        obterContainer().appendChild(toast);
        return toast;
    }

    window.Toast = {
        mostrar: mostrar,
        sucesso: function (msg, op) { return mostrar(msg, Object.assign({}, op, { tipo: 'sucesso' })); },
        erro:    function (msg, op) { return mostrar(msg, Object.assign({}, op, { tipo: 'erro' })); },
        aviso:   function (msg, op) { return mostrar(msg, Object.assign({}, op, { tipo: 'aviso' })); },
        info:    function (msg, op) { return mostrar(msg, Object.assign({}, op, { tipo: 'info' })); }
    };

    // compatibilidade com o código anterior
    window.mostrarAviso = function (msg) { return window.Toast.sucesso(msg); };
})();