//
//  DIConfiguration.swift
//  Zip
//
//

import Foundation
import Resolver

extension DIConnector {
    static func registerAllRibs() {
        DIContainer.register(RootBuildable.self) { _, args in
            return RootBuilder(dependency: args.get())
        }

        DIContainer.register(HomeBuildable.self) { _, args in
            return HomeBuilder(dependency: args.get())
        }

        DIContainer.register(OpenFolderBuildable.self) {_, args in
            return OpenFolderBuilder(dependency: args.get())
        }

        DIContainer.register(FolderDetailBuildable.self) { _, args in
            return FolderDetailBuilder(dependency: args.get())
        }

        DIContainer.register(RenameItemBuildable.self) { _, args in
            return RenameItemBuilder(dependency: args.get())
        }

        DIContainer.register(SelectDestinationBuildable.self) { _, args in
            return SelectDestinationBuilder(dependency: args.get())
        }

        DIContainer.register(CreateFolderBuildable.self) { _, args in
            return CreateFolderBuilder(dependency: args.get())
        }

        DIContainer.register(AddFilePopupBuildable.self) { _, args in
            return AddFilePopupBuilder(dependency: args.get())
        }

        DIContainer.register(SelectMediaBuildable.self) { _, args in
            return SelectMediaBuilder(dependency: args.get())
        }

        DIContainer.register(PreviewVideoBuildable.self) { _, args in
            return PreviewVideoBuilder(dependency: args.get())
        }

        DIContainer.register(PreviewImageBuildable.self) { _, args in
            return PreviewImageBuilder(dependency: args.get())
        }
    }
}
