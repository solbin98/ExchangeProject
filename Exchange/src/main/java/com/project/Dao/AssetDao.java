package com.project.Dao;

import org.apache.ibatis.annotations.Param;

import com.project.Dto.AssetDto;
import com.project.Dto.AssetSearchDto;

public interface AssetDao {
	public AssetDto getAsset(@Param("dto")AssetSearchDto dto);
}
