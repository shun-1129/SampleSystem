param (
    [string]$csprojPath
)

if (-Not (Test-Path $csprojPath)) {
    Write-Host "Error: File not found - $csprojPath"
    exit 1
}

$MSBuildProjectName = "$"+"(MSBuildProjectName)"
$MSBuildProjectNameReplace = "$"+"(MSBuildProjectName.Replace(' ', '_'))"

# XML の読み込み
[xml]$xml = Get-Content $csprojPath

# PropertyGroup を取得
$propertyGroup = $xml.Project.PropertyGroup

# `<AssemblyName>` 要素を追加（存在しない場合）
if (-Not $propertyGroup.AssemblyName) {
    $assemblyName = $xml.CreateElement("AssemblyName")
    $assemblyName.InnerText = "SampleSystem.$MSBuildProjectName"
    $propertyGroup.AppendChild($assemblyName) | Out-Null
}

# `<RootNamespace>` 要素を追加（存在しない場合）
if (-Not $propertyGroup.RootNamespace) {
    $rootNamespace = $xml.CreateElement("RootNamespace")
    $rootNamespace.InnerText = "SampleSystem.$MSBuildProjectNameReplace"
    $propertyGroup.AppendChild($rootNamespace) | Out-Null
}

# 変更を保存
$xml.Save($csprojPath)

Write-Host "Updated $csprojPath successfully."
