# Edit-MST.ps1
 param($mstPath)

 try {
   # Create Orca COM object to interact with the MST
     $orca = New-Object -ComObject "Orca.MsiTransform"

       # Open the MST file for editing
     $orca.OpenDatabase($mstPath)

           # ====================
             # CUSTOM ACTIONS
               # ====================

      # 1. Set properties like REBOOT=1, LIMITUI=1, etc.
      $orca.Execute("UPDATE Property SET Value='1' WHERE Property='REBOOT'")
      $orca.Execute("UPDATE Property SET Value='1' WHERE Property='LIMITUI'")
      $orca.Execute("UPDATE Property SET Value='0' WHERE Property='CERTNumber'")

     # 2. Remove unwanted shortcut
     $orca.Execute("DELETE FROM Shortcut WHERE Shortcut='UnwantedShortcut'")
     # 3. Create "Business Tools" folder
     $orca.Execute("INSERT INTO Directory (Directory, Parent, Name) VALUES ('BUSINESSTOOLS', 'TARGETDIR', 'Business Tools')")

     # 4. Remove launch conditions
     $orca.Execute("DELETE FROM LaunchCondition")
    # ====================
    # Save and close
    # ====================
    $orca.CloseDatabase()
  }
  catch {
      Write-Error "Failed to modify MST: $_"
      exit 1
  } 
