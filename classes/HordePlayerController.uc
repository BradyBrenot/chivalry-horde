class HordePlayerController extends CMWTO2PC;

reliable client function ClientSetHUD(class<HUD> newHUDType)
{
	super.ClientSetHUD(newHUDType);
	CMWTO2HUD(myHUD).SelectedTeam = EFAC_Mason;
}

simulated function DisplayDebug(HUD HUD, out float out_YL, out float out_YPos)
{
	local Canvas	Canvas;
	
	Canvas = HUD.Canvas;
	Canvas.SetDrawColor(255,255,255);
	
	out_YPos += 3*out_YL;
	HUD.Canvas.SetPos(4, out_YPos);

	Canvas.DrawText("HUD:" $ (myHUD.Name));
	out_YPos += out_YL;
	Canvas.SetPos(4,out_YPos);
		
	Canvas.DrawText("GRI:" $ Worldinfo.GRI.Name);
	out_YPos += out_YL;
	Canvas.SetPos(4,out_YPos);

	Canvas.DrawText("GRI skip:" $ CMWTO2GRI(Worldinfo.GRI).bSkipTeamSelect);
	out_YPos += out_YL;
	Canvas.SetPos(4,out_YPos);

	Super.DisplayDebug(HUD, out_YL, out_YPos);
}

reliable client function NotifySpawnInterval(float Time)
{
	local string MovieName;
	GetCurrentMovie(MovieName);
	if (MovieName == "" && LocalPlayer( Player ).ViewportClient != none)
	{
		//update to show the current respawn timer in hud
		MySpawnTime = int(Time);
		//AOCBaseHUD(myHUD).ShowRespawnTimer(true);
		//AOCBaseHUD(myHUD).UpdateRespawnTimer(MySpawnTime);
		SetTimer(1.0f, true, 'HandleSpawnTimer');
	}
}