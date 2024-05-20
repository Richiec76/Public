Location = 'northeurope'

Get-AzVMSize -Location northeurope

# See Image Offers
Get-AzVMImageOffer -Location northeurope -PublisherName MicrosoftWindowsDesktop 

Get-AzVMImageOffer -Location northeurope -PublisherName MicrosoftWindowsServer 

Get-AzVMImageOffer -Location northeurope -PublisherName MicrosoftSQLServer 

#See Skus of Images
Get-AzVMImageSku -Location northeurope -PublisherName MicrosoftWindowsDesktop -Offer Windows-10

Get-AzVmImageSku -Location northeurope -PublisherName MicrosoftSQLServer -Offer sql2019-ws2019

