package com.manager.api.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.manager.api.model.ClubeHasUpgrade;
import com.manager.api.model.ClubeHasUpgradeId;
import com.manager.api.responses.ClubeHasUpgradeResponse;

public interface ClubeHasUpgradeRepository extends JpaRepository<ClubeHasUpgrade, ClubeHasUpgradeId> {

	List<ClubeHasUpgrade> findByIdClubeId(Integer clubeId);

	@Query("""
			SELECT new com.manager.api.responses.ClubeHasUpgradeResponse(
			u.idUpgrade, u.nomeUpgrade, u.preco, u.tipoUpgrade,
			u.descricao, u.modificador, chu.nivelAtual, u.nivelMaximo)
			FROM ClubeHasUpgrade chu
			JOIN Upgrade u ON u.idUpgrade = chu.id.upgradeId
			WHERE chu.id.clubeId = :clubeId
			""")
	List<ClubeHasUpgradeResponse> buscarUpgradesDoClube(@Param("clubeId") Integer clubeId);

	@Query("""
			SELECT new com.manager.api.responses.ClubeHasUpgradeResponse(
			u.idUpgrade, u.nomeUpgrade, u.preco, u.tipoUpgrade,
			u.descricao, u.modificador, chu.nivelAtual, u.nivelMaximo)
			FROM ClubeHasUpgrade chu
			JOIN Upgrade u ON u.idUpgrade = chu.id.upgradeId
			WHERE chu.id.clubeId = :clubeId AND chu.id.upgradeId = :upgradeId
			""")
	Optional<ClubeHasUpgradeResponse> buscarUpgradeDoClube(@Param("clubeId") Integer clubeId,
														  @Param("upgradeId") Integer upgradeId);
}