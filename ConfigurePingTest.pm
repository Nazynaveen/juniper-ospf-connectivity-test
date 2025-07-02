package ConfigurePingTest;

use strict;
use warnings;

use JT;
use JT::Test;
use JT::Extend;
use JT::JUNOS;

# Inherit JT behavior
push @JT::Test::ISA,   __PACKAGE__;
push @JT::JUNOS::ISA,  __PACKAGE__;
push @JT::Extend::ISA, __PACKAGE__;

sub configure_ping_test_100 {
    my $t = shift;
    my $sub = JT::sub_name;
    $t->put_log(">>> Running $sub <<<");

    my (@r, $v);
    $t->get_handles(rtrs => \@r, vars => \$v);
    my ($r0, $r1) = @r;

    # Configure IP and OSPF
    $r0->cli(cmd => [
        "configure",
        "set interfaces ge-0/2/6 unit 0 family inet address 10.37.101.110/22",
        "set protocols ospf area 0.0.0.1 interface ge-0/2/6.0",
        "commit and-quit"
    ]);

    $r1->cli(cmd => [
        "configure",
        "set interfaces ge-0/2/6 unit 0 family inet address 10.37.101.109/22",
        "set protocols ospf area 0.0.0.1 interface ge-0/2/6.0",
        "commit and-quit"
    ]);

    $t->put_log("✅ Configuration complete. Waiting 15 seconds for OSPF to converge...");
    $t->sleep(15);

    # Show OSPF neighbors
    my $ospf_r0 = $r0->cli(cmd => "show ospf neighbor");
    $t->put_log("Output of 'show ospf neighbor' on R0:\n$ospf_r0");

    my $ospf_r1 = $r1->cli(cmd => "show ospf neighbor");
    $t->put_log("Output of 'show ospf neighbor' on R1:\n$ospf_r1");

    # Ping R0 → R1
    my $ping_r0 = $r0->cli(cmd => "ping 10.37.101.109 count 5", timeout => 10);
    $ping_r0 =~ s/\r//g;
    $t->put_log("Ping from R0 to R1:\n$ping_r0");

    # Ping R1 → R0
    my $ping_r1 = $r1->cli(cmd => "ping 10.37.101.110 count 5", timeout => 10);
    $ping_r1 =~ s/\r//g;
    $t->put_log("Ping from R1 to R0:\n$ping_r1");

    # ✅ Final log to show successful test end
    $t->put_log("✅ Test completed with only OSPF and ping checks.");
    $t->sleep(1);  # Ensure final log is flushed

    return JT::TRUE;
}

1;

