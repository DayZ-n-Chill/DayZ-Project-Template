[WorkbenchPluginAttribute("Kill: Dayz ", "Shutdown All Diag64 Tasks", "ctrl+4", "", {"ResourceManager","ScriptEditor"})]
class KillModTool: DayZTool
{
	[Attribute("P:/Mod-Name/Workbench/ToolAddons/Batch/Sysops/Kill_DayZ-Diag64.bat", "", "Starts Cherno Server", "")]
    string BatchFile;
    
	override void Run()
    {
      RunDayZBat(BatchFile, true);
    }
}
