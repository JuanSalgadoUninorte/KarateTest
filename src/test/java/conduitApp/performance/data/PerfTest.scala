package performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class PerfTest extends Simulation {

  val protocol = karateProtocol(
    "/api/articles/{articleId}" -> Nil
  )

  val create = scenario("Create and delete article").exec(karateFeature("classpath:conduitApp/performance/data/create_article.feature"))

  setUp(
    create.inject(atOnceUsers(3)).protocols(protocol)
  )

}
