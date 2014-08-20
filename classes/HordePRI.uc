class HordePRI extends AOCPRI;

simulated function bool ShouldBroadCastWelcomeMessage(optional bool bExiting)
{
	return super.ShouldBroadCastWelcomeMessage(bExiting) && AOCPlayerController(Owner) != none;
}