<#
    .SYNOPSIS
    Fetches additional package info for Chocolatey Package from web page.
    .DESCRIPTION
    Fetches additional package info for Chocolatey Package from web page.
    .EXAMPLE
    PS> Get-ChocoWebData -PackageName adobereader -Verbose

    ImageUrl                                                                                              Author
    --------                                                                                              ------
    https://rawgit.com/itigoag/chocolatey.adobe-acrobat-reader-dc/master/icon/adobe-acrobat-reader-dc.png Adobe
#>
function Get-ChocoWebData {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ValueFromPipeline)]
        [string]$PackageName
    )

    begin {
    }

    process {
        Write-Verbose "Getting Web Data for Package: $PackageName"
        $uri = "https://chocolatey.org/packages/" + $PackageName
        #$packageInfo = New-Object -TypeName PSCustomObject

        try {
            Write-Verbose "Package URL is: $uri"
            $htmlObj = Invoke-WebRequest $uri -ErrorVariable webError

            # get Logo Object and Image
            $logoObj = $htmlObj.ParsedHtml.getElementsByTagName("img") | Where-Object {$_.ClassName -eq "Logo"}

            # extract Logo Image
            $titleStr = $LogoObj.title
            $titleStr = $titleStr -replace "^.*<iconUrl>",""
            $titleStr = $titleStr -replace "</iconUrl>.*$",""
            Write-Verbose "Package Icon Url is: $titleStr"
            $packageInfo = 1 | Select-Object -Property @{Name = "ImageUrl";Expression = {$titleStr}}
            # get author info
            $authorObj = $htmlObj.ParsedHtml.getElementsByTagName("ul") | Where-Object {$_.ClassName -eq "Authors"}
            $authorInfo = $authorObj.innerHtml
            $author = $authorInfo -replace "\s*<li>",""
            $author = $author -replace "</li>\s*",""
            $packageInfo = $packageInfo | Select-Object -Property *,@{Name = "Author";Expression = {$author}}
            return $packageInfo

        }
        catch
        {
            Write-Warning "Could not invoke web request"
            return $webError
        }
    }

    end {
    }
}

#Get-ChocoWebData -PackageName adobereader -Verbose