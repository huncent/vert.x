package vertx.tests.net;

import org.vertx.java.core.Handler;
import org.vertx.java.core.net.NetSocket;
import org.vertx.java.core.shareddata.SharedData;

import java.util.Set;
import java.util.UUID;

/**
 * @author <a href="http://tfox.org">Tim Fox</a>
 */
public class InstanceCheckServer extends BaseServer {

  private final String id = UUID.randomUUID().toString();

  public InstanceCheckServer() {
    super(true);
  }

  protected Handler<NetSocket> getConnectHandler() {
    return new Handler<NetSocket>() {

      public void handle(final NetSocket socket) {

        check.check();
        //We add the object id of the server to the set
        Set<String> set = SharedData.getSet("instances");
        set.add(id);
        SharedData.getCounter("connections").increment();

        socket.close();
      }
    };
  }
}