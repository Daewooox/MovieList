import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        Resolver.register { MovieService.shared() }
    }
}
