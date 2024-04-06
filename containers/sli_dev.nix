
  buildImage,
  pullImage,
  pkgs,
  ...
}:
rec{
slidev = pullImage {
 imageName = "tangramor/slidev";
 imageDigest = "sha256:1b49353c0dd75089ef5fb0fd0d833355355bb879132c818a91484b0b4b52513b";
 sha256 = "09bvcj27sr8fm48gwcf2gvcn79zqqh25axm7y4v0dkg8fc7fa7s3";
 finalImageName = "tangramor/slidev";
 finalImageTag = "latest";
  };

  slidev_custom = buildImage {
    name = "slidev";
    tag = "custom";

    FromImage = slidev;
    copyToRoot = {
      paths = [ ". /slidev" ];
    };
    
    
  };
}

