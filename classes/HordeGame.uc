class HordeGame extends CMWTO2;

static event class<GameInfo> SetGameType(string MapName, string Options, string Portal)
{
	return class'HordeGame';
}

function ScoreKill(Controller Killer, Controller Other)
{
	super.ScoreKill(Killer, Other);
}

function InitGame(string Options, out string ErrorMessage)
{
	if(CMWTO2MapInfo(Worldinfo.GetMapInfo()) != none)
	{
		CMWTO2MapInfo(Worldinfo.GetMapInfo()).OverrideAgathaArcherFamily = CMWTO2MapInfo(Worldinfo.GetMapInfo()).OverrideMasonArcherFamily;
		CMWTO2MapInfo(Worldinfo.GetMapInfo()).OverrideAgathaKnightFamily = CMWTO2MapInfo(Worldinfo.GetMapInfo()).OverrideMasonKnightFamily;
		CMWTO2MapInfo(Worldinfo.GetMapInfo()).OverrideAgathaManAtArmsFamily = CMWTO2MapInfo(Worldinfo.GetMapInfo()).OverrideMasonManAtArmsFamily;
		CMWTO2MapInfo(Worldinfo.GetMapInfo()).OverrideAgathaVanguardFamily = CMWTO2MapInfo(Worldinfo.GetMapInfo()).OverrideMasonVanguardFamily;
	}
	super.InitGame(Options, ErrorMessage);
}

function InitGameReplicationInfo()
{
	super.InitGameReplicationInfo();
	CMWTO2GRI(GameReplicationInfo).bSkipTeamSelect = true;
	CMWTO2GRI(GameReplicationInfo).TeamIndicatorMode = TIMODE_All;
}

function StartRound()
{
	super.StartRound();
	self.ActivateRemoteEvent('HordeMod', none, none);
}

State AOCRoundInProgress
{
	function Timer()
	{
		TimeLeft = 42;
		super.Timer();
	}
}

function SetMinSpawnTimeKismetBonus(float MinSpawnBonus, EAOCFaction AffectedTeam)
{
	local QueueInfo QI;
	local int i;
	super.SetMinSpawnTimeKismetBonus(MinSpawnBonus, AffectedTeam);

	SpawnQueueTimer();

	foreach SpawnQueueReady(QI,i)
	{
		SpawnQueueReady[i].MinRespawnTime = Worldinfo.TimeSeconds + MinSpawnBonus;
	}
	
	SpawnReadyPlayers();
}

DefaultProperties
{
	SpawnWaveInterval=1

    PlayerControllerClass=class'HordePlayerController'
    //DefaultPawnClass=class'AOGMobilePawn'
	
	//This is the name that shows in the server browser for this mod:
	ModDisplayString="Horde"
	PlayerReplicationInfoClass=class'HordePRI'
	GameReplicationInfoClass=class'HordeGRI'

	// do some initialization work here
	Families(ECLASS_Archer)=class'AOCFamilyInfo_Mason_Archer'
	Families(ECLASS_ManAtArms)=class'AOCFamilyInfo_Mason_ManAtArms'
	Families(ECLASS_Vanguard)=class'AOCFamilyInfo_Mason_Vanguard'
	Families(ECLASS_Knight)=class'AOCFamilyInfo_Mason_Knight'
	// test comment
	// same order as above for Masons, but we cant do maths in the thingys.
	Families(5)=class'AOCFamilyInfo_Mason_Archer'
	Families(6)=class'AOCFamilyInfo_Mason_ManAtArms'
	Families(7)=class'AOCFamilyInfo_Mason_Vanguard'
	Families(8)=class'AOCFamilyInfo_Mason_Knight'
}