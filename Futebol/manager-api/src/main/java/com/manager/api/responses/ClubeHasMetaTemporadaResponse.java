package com.manager.api.responses;

import com.manager.api.enums.metaTemporada.Status;

import com.manager.api.model.Clube;
import com.manager.api.model.MetaTemporada;

public record ClubeHasMetaTemporadaResponse(
        Integer idClube,
        Clube clube,
        Integer idMetaTemporada,
        MetaTemporada metaTemporada,
        Status status
) {}