package dk.lrn

import org.eclipse.microprofile.config.inject.ConfigProperty
import javax.enterprise.context.ApplicationScoped
import javax.inject.Inject
import javax.ws.rs.GET
import javax.ws.rs.Path
import javax.ws.rs.Produces
import javax.ws.rs.core.MediaType

@Path("/hello")
class ExampleResource(

        @ConfigProperty(name = "greeting.message", defaultValue = "PRIT")
        val message: String
) {

    val quarkus = "test1"


    @GET
    @Produces(MediaType.TEXT_PLAIN)
    fun hello() = quarkus+message
}