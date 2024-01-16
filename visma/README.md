# pss-public // visma
If you work in IT and you work with on-premise Visma solutions in Scandinavia, I'm sure you have problems with the services always stopping by themselves and not starting again automatically. I have stopped expecting Visma to solve the issue with their buggy services so I developed a script to deal with it.

These scripts will try to gracefully restart the Visma services, and if they cannot be gracefully restarted, the script will kill the processes associated with the services before starting them all again.

After developing this script I have been running it in Task Scheduler every morning at 6am. You can of course also schedule something in an RMM solution.

# Reasons for using this script (in English and Norwegian for SEO):
- Visma Document Center crashes
- Visma Document Center stops
- Visma Document Center service
- Visma Business crashes
- Visma Business stops
- Visma Business service
- Visma Dokument Center krasjer
- Visma Dokument Center stopper
- Visma Business krasjer
- Visma Business krasjer
- Visma tjenester stopper
- Visma tjenester krasjer
- Visma Windows tjenester
