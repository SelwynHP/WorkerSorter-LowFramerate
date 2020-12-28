$targetFramerate = 40
#Get files from dir
$fList = (Get-ChildItem *.avi, *.divx, *.dvx, *.f4p, *.f4v, *.fli, *.flv,
 *.mp4, *.mov, *.m4v, *.mpg, *.mpeg, *.wmv, *.mkv, *.xvid -File)
#Identify framerate of each file
foreach($var in $fList){
    $framerate = -1
    # ffprobe returns framerate as a String representing fraction rather than a number('240/1' instead of 240)
    # we split the string to later perform a division to get the number
    $fr = $(ffprobe -v error -select_streams v -of default=noprint_wrappers=1:nokey=1 -show_entries stream=r_frame_rate $var.FullName).Split('/')
    # casting strings as ints
    $fr[0] = $fr[0] -as [int]
    $fr[1] = $fr[1] -as [int]
    # performing division to get actual framerate
    $framerate = $fr[0] / $fr[1]
    $path = $('.\'+'30FPS')
    if($(Test-Path $path) -ne $true){New-Item -Path $path -ItemType Directory}
#Move files based on condition
    if($framerate -le $targetFramerate -and $framerate -gt -1)
    {
        Move-Item $var.FullName.Replace("[", "``[").replace("]", "``]") $path
    }#closes if statement (framerate)
}#closes foreach





############Testing Area##############
#$fList
#$framerate