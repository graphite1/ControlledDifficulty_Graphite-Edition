class CD_SpawnCycle_Preset_graphite_basic
	extends CD_SpawnCycle_PresetBase
	implements (CD_SpawnCycle_Preset);

function GetShortSpawnCycleDefs( out array<string> sink )
{
	sink.length = 0;
	sink.length = 4;

	sink[0] = "4CC,3CC_1AL,4CR,3AL_1GF,4ST,2SL";
	sink[1] = "4CR,3CC_1BL,2AL_2GF,4ST,1HU";
	sink[2] = "3CC_1AL,4CR,2SL_2GF,2ST,1SC";
	sink[3] = "4CR,3AL_1GF,2HU,2ST,1SC,1FP";
}

function GetNormalSpawnCycleDefs( out array<string> sink )
{
	sink.length = 0;
	sink.length = 7;

	sink[0] = "4CC,3CC_1AL,4CR,3AL_1GF,4ST,2SL";
	sink[1] = "4CR,3CC_1BL,2AL_2GF,4ST,1HU";
	sink[2] = "3CC_1AL,4CR,2SL_2GF,2ST,1SC";
	sink[3] = "4CR,3AL_1GF,2HU,2ST,1SC";
	sink[4] = "3CC_1BL,4CR,2AL_2GF,2HU,1SC";
	sink[5] = "4ST,4CR,2SL_2GF,1HU,1SC,1FP";
	sink[6] = "4CR,3AL_1GF,2HU,2SC,1FP";
}

function GetLongSpawnCycleDefs( out array<string> sink )
{
	sink.length = 0;
	sink.length = 10;

	sink[0] = "4CC,3CC_1AL,4CR,3AL_1GF,4ST,2SL";
	sink[1] = "4CR,3CC_1BL,2AL_2GF,4ST,1HU";
	sink[2] = "3CC_1AL,4CR,2SL_2GF,2ST,1SC";
	sink[3] = "4CR,3AL_1GF,2HU,2ST,1SC";
	sink[4] = "3CC_1BL,4CR,2AL_2GF,2HU,1SC";
	sink[5] = "4ST,4CR,2SL_2GF,1HU,1SC,1FP";
	sink[6] = "4CR,3AL_1GF,2HU,2SC,1FP";
	sink[7] = "3CC_1BL,4CR,2AL_2GF,2HU,2SC";
	sink[8] = "4ST,4CR,2SL_2GF,2HU,1SC,1FP";
	sink[9] = "4CR,3AL_1GF,2HU,2SC,2FP";
}

function string GetDate()
{
	return "2026-07-05";
}

function string GetAuthor()
{
	return "Graphite Edition";
}

