import ProjectDescription

let config = Config(
  plugins: [
    .local(path: .relativeToManifest("../../Plugins/ThirdPartyDependencyPlugin")),
    .local(path: .relativeToManifest("../../Plugins/ResourceKitPlugin")),
    .local(path: .relativeToManifest("../../Plugins/FeaturePlugin")),
  ]
)
