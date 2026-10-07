<link rel="stylesheet" href="assets/css/clube_patrocinios.css">

<?php
$apiService = new ApiService();
$patrocinadores = $apiService->get("/patrocinios");
?>

<main>

    <h1 class="titulo">Patrocínios</h1>

    <div class="layout">

        <section class="box" id="painel-detalhe">
            <div class="detalhe-topo">
                <div id="detalhe-logo"></div>
                <div>
                    <strong id="detalhe-nome">Selecione um patrocinador</strong><br>
                    <span>Proposta selecionada</span>
                </div>
            </div>

            <div class="stats-grid">
                <div class="stat-item"><span>Valor mensal</span><strong id="detalhe-valor">-</strong></div>
                <div class="stat-item"><span>Multa de rescisão</span><strong id="detalhe-multa">-</strong></div>
                <div class="stat-item"><span>Contrato</span><strong id="detalhe-duracao">-</strong></div>
            </div>

            <div>
                <h2>Sobre a empresa</h2>
                <p class="descricao" id="detalhe-descricao">-</p>
            </div>

            <button class="btn-assinar" id="btn-assinar" data-id="">Assinar Contrato</button>
        </section>

        <section class="box">
            <h2>Propostas Disponíveis</h2>
            <div class="lista-patrocinadores">
                <?php foreach ($patrocinadores as $patrocinador) { ?>
                    <div class="patrocinador-item"
                        data-id="<?= htmlspecialchars($patrocinador['idPatrocinador']) ?>"
                        data-nome="<?= htmlspecialchars($patrocinador['nomePatrocinador']) ?>"
                        data-descricao="<?= htmlspecialchars($patrocinador['descricao']) ?>"
                        data-duracao="<?= htmlspecialchars($patrocinador['duracao']) ?>"
                        data-valor="<?= htmlspecialchars(formatarNumero($patrocinador['valorMensal'])) ?>"
                        data-multa="<?= htmlspecialchars(formatarNumero($patrocinador['multaRescisao'])) ?>"
                        data-foto="<?= htmlspecialchars($patrocinador['foto'] ?? '') ?>">
                        <img src="assets/<?= htmlspecialchars($patrocinador['foto'] ?? '') ?>" style="width: 62px !important; height: 62px !important; object-fit: contain;" alt="">
                        <div class="patrocinador-info">
                            <div class="linha-topo"><strong><?= htmlspecialchars($patrocinador['nomePatrocinador']) ?></strong><span class="valor">R$ <?= formatarNumero($patrocinador['valorMensal']) ?></span></div>
                            <span class="tempo">Contrato de <?= $patrocinador['duracao'] ?> meses</span>
                            <span class="resumo"><?= limitarTexto($patrocinador['descricao'], 40) ?></span>
                        </div>
                    </div>
                <?php } ?>
            </div>
        </section>

    </div>

</main>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        var itens = document.querySelectorAll('.patrocinador-item[data-id]');
        var logo = document.getElementById('detalhe-logo');
        var nome = document.getElementById('detalhe-nome');
        var valor = document.getElementById('detalhe-valor');
        var multa = document.getElementById('detalhe-multa');
        var duracao = document.getElementById('detalhe-duracao');
        var descricao = document.getElementById('detalhe-descricao');
        var btnAssinar = document.getElementById('btn-assinar');

        function iniciais(texto) {
            return texto
                .split(' ')
                .filter(function (p) { return p.length > 0; })
                .slice(0, 2)
                .map(function (p) { return p[0].toUpperCase(); })
                .join('');
        }

        function selecionar(item) {
            itens.forEach(function (i) { i.classList.remove('selecionado'); });
            item.classList.add('selecionado');

            var d = item.dataset;

            logo.innerHTML = '';
            if (d.foto) {
                var img = document.createElement('img');
                img.src = 'assets/' + d.foto;
                img.alt = d.nome;
                img.style.width = '62px';
                img.style.height = '62px';
                img.style.objectFit = "contain";
                logo.className = '';
                logo.appendChild(img);
            } else {
                logo.className = 'logo-patrocinio';
                logo.textContent = iniciais(d.nome);
            }

            nome.textContent = d.nome;
            valor.textContent = 'R$ ' + d.valor;
            multa.textContent = 'R$ ' + d.multa;
            duracao.textContent = d.duracao + ' meses';
            descricao.textContent = d.descricao;
            btnAssinar.dataset.id = d.id;
        }

        itens.forEach(function (item) {
            item.style.cursor = 'pointer';
            item.addEventListener('click', function () {
                selecionar(item);
            });
        });

        if (itens.length > 0) {
            selecionar(itens[0]);
        }
    });
</script>