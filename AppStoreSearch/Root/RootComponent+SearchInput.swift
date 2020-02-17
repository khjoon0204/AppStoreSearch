//
//  Copyright (c) 2017. Uber Technologies
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

/// The dependencies needed from the parent scope of Root to provide for the SearchTabbar scope.
// TODO: Update RootDependency protocol to inherit this protocol.
protocol RootDependencySearchTabbar: Dependency {

    // TODO: Declare dependencies needed from the parent scope of Root to provide dependencies
    // for the SearchTabbar scope.
}

extension RootComponent: SearchTabbarDependency {

//    var searchTabbarViewController: SearchTabbarViewControllable {
//        return rootViewController
//    }
}

