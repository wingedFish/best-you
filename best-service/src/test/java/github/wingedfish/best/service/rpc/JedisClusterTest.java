package github.wingedfish.best.service.rpc;

import org.apache.commons.lang3.math.NumberUtils;
import org.junit.Test;
import redis.clients.jedis.HostAndPort;
import redis.clients.jedis.JedisCluster;

import java.util.HashSet;
import java.util.Set;

public class JedisClusterTest {

    private static final String redisAddress = "";
    private static final Set<HostAndPort> nodes = new HashSet<>();

    static {
        for (String ipPort : redisAddress.split(",")) {
            String[] ipInfo = ipPort.split(":");
            HostAndPort node = new HostAndPort(ipInfo[0], NumberUtils.toInt(ipInfo[1]));
            nodes.add(node);
        }
    }


    @Test
    public void testConnection() {
        JedisCluster jedisCluster = new JedisCluster(nodes);
        jedisCluster.setex("klov",1000,"xhli");
    }

}
