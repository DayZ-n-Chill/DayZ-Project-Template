[WorkbenchPluginAttribute("Kill: Dayz ", "Shutdown All Diag64 Tasks", "ctrl+3", "", {"ResourceManager","ScriptEditor"})]
class KillModTool: DayZTool
{
    string BatchFile;
    void KillModTool()
    {
		 BatchFile = "P:/Mod-Name/Workbench/ToolAddons/Batch/Sysops/Kill_DayZ-Diag64.bat";
    }
    override void Run()
    {
        RunDayZBat(BatchFile, true);
    }
}
