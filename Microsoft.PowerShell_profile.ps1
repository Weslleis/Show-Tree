function Show-Tree {
    param (
        [string]$Path = ".",
        [string]$Indent = "",
        [switch]$IsLast,
        [string[]]$Ignore = @(),
        [string]$Root = (Resolve-Path ".").Path,
        [switch]$Checksum
    )

    function Get-RelativePath($FullPath, $BasePath) {
        $full = (Resolve-Path $FullPath).Path
        $base = (Resolve-Path $BasePath).Path
        return $full.Substring($base.Length).TrimStart('\', '/').Replace('\', '/')
    }

    function Test-IgnorePath($RelativePath, $IgnorePatterns) {
        foreach ($pattern in $IgnorePatterns) {
            if ($pattern -eq "") { continue }
            $pattern = $pattern.TrimEnd("/")
            $regex = '^' + [Regex]::Escape($pattern).
                Replace('\*\*/', '(.*/)?').
                Replace('\*\*', '.*').
                Replace('\*', '[^/]*').
                Replace('\?', '.') + '(/.*)?$'
            if ($RelativePath -match $regex) { return $true }
        }
        return $false
    }

    function Get-FileHashMD5($FilePath) {
        try {
            return (Get-FileHash -Algorithm MD5 -Path $FilePath).Hash
        } catch {
            return "ERROR_HASH"
        }
    }

    # Lê .treeignore se estiver na raiz
    if ($Path -eq "." -and (Test-Path ".treeignore")) {
        $Ignore = Get-Content ".treeignore" | Where-Object { $_ -and ($_ -notmatch '^\s*#') }
    }

    # Exibe a pasta raiz apenas na chamada inicial
    if ($Indent -eq "") {
        $rootName = Split-Path -Path (Resolve-Path $Path).Path -Leaf
        Write-Output "$rootName/"
    }

    # Lista e filtra os itens do diretório
    $items = Get-ChildItem -LiteralPath $Path -Force |
        Where-Object {
            $rel = Get-RelativePath $_.FullName $Root
            -not (Test-IgnorePath $rel $Ignore)
        }

    $files = $items | Where-Object { -not $_.PSIsContainer } | Sort-Object Name
    $dirs  = $items | Where-Object { $_.PSIsContainer } | Sort-Object Name
    $items = @($files) + @($dirs)

    $itemCount = $items.Count

    for ($i = 0; $i -lt $itemCount; $i++) {
        $item = $items[$i]
        $isLastItem = ($i -eq $itemCount - 1)
        $prefix = if ($isLastItem) { "└── " } else { "├── " }
        $subIndent = if ($isLastItem) { "$Indent    " } else { "$Indent│   " }

        if ($item.PSIsContainer) {
            Write-Output "$Indent$prefix$($item.Name)/"
            Show-Tree -Path $item.FullName -Indent $subIndent -IsLast:$isLastItem -Ignore $Ignore -Root $Root -Checksum:$Checksum
        } else {
            if ($Checksum) {
                $hash = Get-FileHashMD5 $item.FullName
                Write-Output "$Indent$prefix$hash  $($item.Name)"
            } else {
                Write-Output "$Indent$prefix$($item.Name)"
            }
        }
    }
}
