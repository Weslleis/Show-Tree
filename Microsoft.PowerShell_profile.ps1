function Show-Tree {
    param (
        [string]$Path = ".",
        [string]$Indent = "",
        [switch]$IsLast = $true,
        [string[]]$Ignore = @(),
        [string]$Root = (Resolve-Path ".").Path
    )

    function Get-RelativePath($FullPath, $BasePath) {
        $full = (Resolve-Path $FullPath).Path
        $base = (Resolve-Path $BasePath).Path
        return $full.Substring($base.Length).TrimStart('\', '/').Replace('\', '/')
    }

    function Should-Ignore($RelativePath, $IgnorePatterns) {
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

    # Lê .treeignore se estiver na raiz
    if ($Path -eq "." -and (Test-Path ".treeignore")) {
        $Ignore = Get-Content ".treeignore" | Where-Object { $_ -and ($_ -notmatch '^\s*#') }
    }

    # Exibe a pasta raiz apenas na chamada inicial
    if ($Indent -eq "") {
        $rootName = Split-Path -Path (Resolve-Path $Path).Path -Leaf
        Write-Output "$rootName/"
    }

    # Obtém todos os itens, aplica filtro e separa arquivos e pastas
    $items = Get-ChildItem -LiteralPath $Path -Force |
        Where-Object {
            $rel = Get-RelativePath $_.FullName $Root
            -not (Should-Ignore $rel $Ignore)
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
            Show-Tree -Path $item.FullName -Indent $subIndent -IsLast:$isLastItem -Ignore $Ignore -Root $Root
        } else {
            Write-Output "$Indent$prefix$($item.Name)"
        }
    }
}