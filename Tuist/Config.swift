import ProjectDescription

let config = Config(
  plugins: [
    .local(path: .relativeToManifest("../../Plugins/ThirdPartyDependencyPlugin")),
    .local(path: .relativeToManifest("../../Plugins/ResourceKitPlugin")),
    .local(path: .relativeToManifest("../../Plugins/FeaturePlugin")),
    .local(path: .relativeToManifest("../../Plugins/DesignSystemPlugin")),
    .local(path: .relativeToManifest("../../Plugins/EntityPlugin")),
    .local(path: .relativeToManifest("../../Plugins/DomainPlugin")),
    .local(path: .relativeToManifest("../../Plugins/DataPlugin")),
    .local(path: .relativeToManifest("../../Plugins/NetworkHelperPlugin"))
  ]
)
